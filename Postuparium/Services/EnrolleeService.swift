//
//  EnrolleeService.swift
//  Postuparium
//
//  Created by Михаил on 22.11.2020.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol EnrolleeServiceProtocol {
    static var shared: EnrolleeServiceProtocol {get}
    var enrollee: Enrollee {get set}
    
    func setFirstName(firstName: String)
    func setLastName(lastName: String)
    func setEgeResults(egeResults:EgeResults)
    func setPersonalAchievements(achievements: PersonalAchievements)
    func setChosenPrograms(programs: [EdProgram])
    
    func commitUpdates(didCommit:@escaping (Enrollee?) -> Void)
    
    func signup(didSignUp:@escaping (Enrollee?) -> Void)
    
    func signin(didSignIn:@escaping (Enrollee?) -> Void)
}

class EnrolleeService: EnrolleeServiceProtocol {
    static var LoginApiURL: String = "http://77.223.97.172:8080/api/v1/login/"
    static var UsersApiURL: String = "http://77.223.97.172:8080/api/v1/users/"
    
    static var shared: EnrolleeServiceProtocol = EnrolleeService()
    
    var enrollee: Enrollee = Enrollee()
    
    private init() {}
    
    func setFirstName(firstName: String) {
        enrollee.firstName = firstName
    }
    
    func setLastName(lastName: String) {
        enrollee.lastName = lastName
    }
    
    func setEgeResults(egeResults: EgeResults) {
        enrollee.egeResults = egeResults
    }
    
    func setPersonalAchievements(achievements: PersonalAchievements) {
        enrollee.achievements = achievements
    }
    
    func setChosenPrograms(programs: [EdProgram]) {
        enrollee.chosenPrograms = programs
    }
    
    func commitUpdates(didCommit:@escaping (Enrollee?) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            didCommit(self.enrollee)
        }
    }

    func signup(didSignUp:@escaping (Enrollee?) -> Void) {
        if enrollee.token == "" {
            enrollee.token = UUID().uuidString
        }
        
        let request = AF.request(EnrolleeService.UsersApiURL, method: .post, parameters: enrollee.dictionary, encoding: JSONEncoding.default)
        
        request.responseJSON { (response) in
            switch response.result {
                case .success:

                    if let json = response.data {
                            let jsonDecoder = JSONDecoder()
                            print("json::: ", response)
                            let person = try! jsonDecoder.decode(Enrollee.self, from: json)
                            person.save()
                            didSignUp(person)
                    }
                case .failure(_):
                    didSignUp(nil)
                }
        }
    }
    
    func signin(didSignIn: @escaping (Enrollee?) -> Void) {
        let request = AF.request(EnrolleeService.LoginApiURL, method: .post, parameters: enrollee.dictionaryLogin)
        
        request.responseJSON { (response) in
            switch response.result {
                case .success:
                    print("Validation Successful)")

                    if let json = response.data {
                            let jsonDecoder = JSONDecoder()
                            var person = try? jsonDecoder.decode(Enrollee.self, from: json)
                        if person == nil {
                            self.signup(didSignUp: {enrolleeDetails in
                                person = enrolleeDetails
                            })
                        }
                        person?.save()
                        didSignIn(person)
                    }
                case .failure(_):
                    didSignIn(nil)
                }
        }
    }
}

