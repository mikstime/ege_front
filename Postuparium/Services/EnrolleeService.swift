//
//  EnrolleeService.swift
//  Postuparium
//
//  Created by Михаил on 22.11.2020.
//

import Foundation

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
        print(enrollee)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            didSignUp(self.enrollee)
        }
    }
    
    func signin(didSignIn: @escaping (Enrollee?) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            didSignIn(self.enrollee)
        }
    }
}

