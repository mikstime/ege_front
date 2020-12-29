//
//  ApplicantsService.swift
//  Postuparium
//
//  Created by Сергей Петренко on 29.12.2020.
//

import Foundation

import UIKit
import Alamofire

protocol ApplicantsServiceProtocol {
    func searchForApplicants(query:String, didFind: @escaping  ([Applicant]) -> Void )
    
}
// принцип работы. Запрошенные с сервера универы хранятся в fetchedUniversities
// ответ на последний запрос – в universities. Переписывать времени нет.
class ApplicantsService: ApplicantsServiceProtocol{
 
    
    
    static var applicantsURL: String = "http://77.223.97.172:8081/api/v1/applicants/" //todo реализовать на беке
    func searchForApplicants(query: String, didFind: @escaping ([Applicant]) -> Void) {
        if query.isEmpty {
            print("empty query")
            getAllApplicants(didLoad: didFind)
        } else {
            searchApplicants(query: query, didFind: didFind)
        }
    }
    
    
    static var shared: ApplicantsServiceProtocol = ApplicantsService()
    var useMocks = true
    private var MOCK_APPLICANTS = [
        Applicant(scores: 300, name: "Василий Романов", id: 1),
        Applicant(scores: 200, name: "Василий Романов", id: 2),
        Applicant(scores: 190, name: "Василий Романов", id: 2),
        Applicant(scores: 180, name: "Василий Романов", id: 3),
        Applicant(scores: 170, name: "Василий Романов", id: 4),
        Applicant(scores: 160, name: "Василий Романов", id: 5),
        Applicant(scores: 150, name: "Василий Романов", id: 6),
        Applicant(scores: 140, name: "Василий Романов", id: 7),
        Applicant(scores: 130, name: "Василий Романов", id: 8),
        Applicant(scores: 120, name: "Василий Романов", id: 9),
        Applicant(scores: 110, name: "Василий Романов", id: 10),
        Applicant(scores: 100, name: "Василий Романов", id: 11),
        Applicant(scores: 90, name: "Василий Романов", id: 12),
        Applicant(scores: 80, name: "Василий Романов", id: 13),
    ]
    
}

extension ApplicantsService {
    private func getAllApplicants(didLoad: @escaping  ([Applicant]) -> Void) {
        let requestURL = ApplicantsService.applicantsURL
        let request = AF.request(requestURL, method: .get)
        
        request.responseJSON { (response) in
            switch response.result {
                case .success:
                    print("response::: ", response.result)
                    if let json = response.data {
                        if self.useMocks {
                            didLoad(self.MOCK_APPLICANTS)
                        } else {
//                            let jsonDecoder = JSONDecoder()
//                            let universities = try! jsonDecoder.decode([University].self, from: json)
//                            didLoad(universities)
                        }
                    }
                case .failure(_):
                    if let json = response.data {
                        if self.useMocks {
                            didLoad(self.MOCK_APPLICANTS)
                        } else {
                           didLoad([])
                        }
                    }
                }
        }
    }
    
    private func searchApplicants(query: String, didFind: @escaping  ([Applicant]) -> Void) {
        getAllApplicants(didLoad: { u in
            didFind(self.filterApplicants(query: query, applicants: u))
            
        })
    }
    private func filterApplicants(query: String, applicants: [Applicant]) -> [Applicant] {
        return applicants.filter { applicant in
            return applicant.name.starts(with: query)
        }
    }
}

