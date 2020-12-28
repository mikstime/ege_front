//
//  EdProgramService.swift
//  Postuparium
//
//  Created by Михаил on 22.11.2020.
//

import Foundation
import Alamofire

protocol EdProgramServiceProtocol {
    static var shared: EdProgramServiceProtocol {get}
    func searchPrograms(searchString: String, university: University!, since: EdProgram?, didFind:@escaping ([EdProgram]?) -> Void)
    func loadChosenPrograms(since: EdProgram!, university: University!, didLoad: @escaping ([EdProgram]?) -> Void)
    func addProgramsToChosen(programs:[EdProgram], done: @escaping () -> Void)
}

class EdProgramService: EdProgramServiceProtocol {
    
    var useMocks = false
    private var MOCKED_PROGRAMS = [
        EdProgram(code: "09.03.01", name: "Прикладная физика", university: "МГТУ им. Н. Э.Баумана", universityId: 1, photo: "http://77.223.97.172:8081/media/1.2.jpg", probability: "10%", probablilityNumber: 0.1, id: 1),
        EdProgram(code: "09.03.01", name: "Прикладная математика", university: "МГУ", universityId: 2, photo: "http://77.223.97.172:8081/media/1.3.jpg", probability: "15%", probablilityNumber: 0.15, id: 2)
    ]
    static var allProgrammsURL: String = "http://77.223.97.172:8081/api/v1/education_programs/"
    static var addChosenURL: String = "http://77.223.97.172:8081/api/v1/education_programs/"
    static var searchProgramsURL: String = ""
    static var universityURL: String = "http://77.223.97.172:8081/api/v1/universities/"
    static var favoriteProgrammsURL: String = "http://77.223.97.172:8081/api/v1/users/education_programs/"
    
    var programs: [EdProgram] = []
    static var shared: EdProgramServiceProtocol = EdProgramService()

    func addProgramsToChosen(programs: [EdProgram], done: @escaping () -> Void) {
        // Поиск по всем направлениям
        let params: [String] = programs.map { program in
            return String(program.id)
        }
        let paramsString: String = params.joined(separator: ", ")
        let res: String = "[" + paramsString + "]"
        print("chosen: ", res)
        let request = AF.request(EdProgramService.allProgrammsURL, method: .post, parameters: res)
            
        request.responseJSON { (response) in
            switch response.result {
                case .success:
                    print("response::: ", response.result)
                    done()
                case .failure(_):
                    print("GET ALL PROGRAMMS FAILED")
                    done()
            }
        }
    }
    
    func searchPrograms(searchString: String, university: University! = nil, since: EdProgram?, didFind:@escaping ([EdProgram]?) -> Void) {

        if searchString.isEmpty {
            if university == nil {
                getAllPrograms(didLoad: didFind)
            } else {
                getUniversityPrograms(university: university, didLoad: didFind)
            }
        } else {
            if university == nil {
                searchInAllPrograms(searchString: searchString, didFind: didFind)
            } else {
                searchInUniversityPrograms(searchString: searchString, university: university, didFind: didFind)
            }
        }
    }
    
    func loadChosenPrograms(since: EdProgram!, university: University! = nil, didLoad: @escaping ([EdProgram]?) -> Void) {

        if university == nil {
            getAllChosenPrograms(didLoad: didLoad)
        } else {
            getUniversityChosenPrograms(univeristy: university, didLoad: didLoad)
        }
    }
}

extension EdProgramService {
    func getAllPrograms(didLoad: @escaping ([EdProgram]?) -> Void) {
        // Поиск по всем направлениям
        let request = AF.request(EdProgramService.allProgrammsURL, method: .get)
            
        request.responseJSON { (response) in
            switch response.result {
                case .success:
                    print("response::: ", response.result)
                    if let json = response.data {
                    
                        let jsonDecoder = JSONDecoder()
                        let edPrograms = try! jsonDecoder.decode([EdProgram].self, from: json)
                        didLoad(edPrograms)
                    
                    }
                case .failure(_):
                    print("GET ALL PROGRAMMS FAILED")
                    didLoad(nil)
            }
        }
    }
    
    func getAllChosenPrograms(didLoad: @escaping ([EdProgram]?) -> Void) {
        let request = AF.request(EdProgramService.favoriteProgrammsURL, method: .get)
        
        request.responseJSON { (response) in
            switch response.result {
                case .success:
                    print("response::: ", response.result)
                    if let json = response.data {
                        if self.useMocks {
                            didLoad(self.MOCKED_PROGRAMS)
                        } else {
                            let jsonDecoder = JSONDecoder()
                            let edPrograms = try! jsonDecoder.decode([EdProgram].self, from: json)
                            didLoad(edPrograms)
                        }
                    }
                case .failure(_):
                    didLoad(nil)
                }
        }
    }
    
    func getUniversityChosenPrograms(univeristy: University, didLoad: @escaping ([EdProgram]?) -> Void) {
        getAllChosenPrograms{ programs in
            if programs == nil {
                didLoad(nil)
            }
            didLoad(programs!.filter { program in
                return program.universityId == univeristy.id
            })
        }
    }
    
    func getUniversityPrograms(university: University, didLoad: @escaping ([EdProgram]?) -> Void) {
        // Получить направления по вузу
        let requestURL = EdProgramService.universityURL + String(university.id) + "/programs"
        let request = AF.request(requestURL, method: .get)
        
        request.responseJSON { (response) in
            switch response.result {
                case .success:
                    print("response::: ", response.result)
                    if let json = response.data {
                        if self.useMocks {
                            didLoad(self.MOCKED_PROGRAMS)
                        } else {
                            let jsonDecoder = JSONDecoder()
                            let edPrograms = try! jsonDecoder.decode([EdProgram].self, from: json)
                            didLoad(edPrograms)
                        }
                    }
                case .failure(_):
                    didLoad(nil)
                }
        }
    }
    
    func searchInUniversityPrograms(searchString: String, university: University, didFind: @escaping ([EdProgram]?) -> Void) {
        getUniversityPrograms(university: university, didLoad: {programs in
            didFind(self.searchInPrograms(programs: programs ?? [], searchString: searchString))
        })
    }
    
    func searchInAllPrograms(searchString: String, didFind: @escaping ([EdProgram]?) -> Void) {
        getAllPrograms{ programs in
            didFind(self.searchInPrograms(programs: programs ?? [], searchString: searchString))
        }
    }
    
    func searchInPrograms(programs: [EdProgram], searchString: String) -> [EdProgram] {
        return programs.filter { program in
            //@TODO прокачать логику поиска
            return program.name.starts(with: searchString)
        }
    }
}
