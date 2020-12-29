//
//  UniversitiesServce.swift
//  Postuparium
//
//  Created by user on 27.12.2020.
//

import Foundation
import UIKit
import Alamofire

protocol UniversitiesServiceProtocol {
    func searchForUniversities(query:String, didFind: @escaping  ([University]) -> Void )
}
// принцип работы. Запрошенные с сервера универы хранятся в fetchedUniversities
// ответ на последний запрос – в universities. Переписывать времени нет.
class UniversitiesService: UniversitiesServiceProtocol{
    
    static var universityURL: String = "http://77.223.97.172:8081/api/v1/universities/"
    func searchForUniversities(query: String, didFind: @escaping ([University]) -> Void) {
        if query.isEmpty {
            getAllUniversities(didLoad: didFind)
        } else {
            searchUniversities(query: query, didFind: didFind)
        }
    }
    
    
    static var shared: UniversitiesServiceProtocol = UniversitiesService()
    var useMocks = true
//    private var MOCK_UNIVERSITIES = [
//        University(scores: 12, numberOfPrograms: 15, place: 192, rating: 3.2, name: "МГТУ им. Н. Э. Баумана", image: "https://www.interfax.ru/ftproot/textphotos/2020/10/20/700ba.jpg", description: "Ну вообще, как бы, это – лучший технический вуз страны. В нем еще твой дед учился. На электрика. Или кого-то еще.", id: 1),
//        University(scores: 270, place: 13, rating: 3.1, name: "МГУ", image:  "https://www.msu.ru/upload/iblock/3f9/20170913_010.jpg", description: "Первый ВУЗ страны после МГТУ", id: 2)
//    ]
    
}

extension UniversitiesService {
    private func getAllUniversities(didLoad: @escaping  ([University]) -> Void) {
        print("get all universities")
        let requestURL = UniversitiesService.universityURL
        let request = AF.request(requestURL, method: .get)
        
        request.responseJSON { (response) in
            switch response.result {
                case .success:
                    print("response::: ", response.result)
                    if let json = response.data {
                        let jsonDecoder = JSONDecoder()
                        print("json::: ", json)
                        let universities = try! jsonDecoder.decode([University].self, from: json)
                        print(universities)
                        didLoad(universities)
                    }
                case .failure(_):
                    print("FAIL:: ", response.result)
                    didLoad([])
                }
        }
    }
    
    private func searchUniversities(query: String, didFind: @escaping  ([University]) -> Void) {
        getAllUniversities(didLoad: { u in
            didFind(self.filterUniversities(query: query, universities: u))
            
        })
    }
    private func filterUniversities(query: String, universities: [University]) -> [University] {
        return universities.filter { university in
            return university.name.starts(with: query)
        }
    }
}

