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
    func loadPrograms(since: EdProgram!, didLoad:@escaping ([EdProgram]?) -> Void)
    func searchPrograms(searchString: String, since: EdProgram?, didFind:@escaping ([EdProgram]?) -> Void)
    func loadChosenPrograms(since: EdProgram!, didLoad:@escaping([EdProgram]?) -> Void)
}

class EdProgramService: EdProgramServiceProtocol {
    static var allProgrammsURL: String = "http://77.223.97.172:8081/api/v1/users/education_programs/"
    
    static var favoriteProgrammsURL: String = "http://77.223.97.172:8081/api/v1/users/education_programs/"
    
    var programs: [EdProgram] = []
    let names = ["Техническая физика", "Математическая информатика", "Вычислительная математика и кибернетика", "Техническая физика", "Математическая информатика"]
    let codes = ["11.0.1", "13.0.2", "14.2.12", "11.0.1", "13.0.2"]
    let universities = ["МГТУ им. Н. Э. Баумана", "МГТУ им. Н. Э. Баумана", "МГУ им. М. В. Ломоносова", "МГТУ им. Н. Э. Баумана", "МГТУ им. Н. Э. Баумана", ]
    let photos = ["https://ekd.me/wp-content/uploads/2019/02/img_52531-e1551272911192.jpg", "https://upload.wikimedia.org/wikipedia/commons/2/25/Moscow%2C_Lefortovskaya_Nab_5_Aug_2009_04.JPG",
        "https://cdn23.img.ria.ru/images/155486/69/1554866980_0:0:3071:2048_1440x900_80_1_1_720a2d8b1c2687afcb3816d7fb2a04be.jpg?source-sid=rian_photo",
        "https://ekd.me/wp-content/uploads/2019/02/img_52531-e1551272911192.jpg", "https://upload.wikimedia.org/wikipedia/commons/2/25/Moscow%2C_Lefortovskaya_Nab_5_Aug_2009_04.JPG",]
    let probabilities = ["86%", "63%", "23%", "86%", "63%"]
    let probablilitiesNumbers = [0.86, 0.63, 0.23, 0.86, 0.63]
    var counter = 0
    static var shared: EdProgramServiceProtocol = EdProgramService()
    
    private init() {
        for _ in 1...10 {
            var program = EdProgram()
            program.name = names[counter % names.count]
            program.code = codes[counter % names.count]
            program.university = universities[counter % names.count]
            program.photo = photos[counter % names.count]
            program.probability = probabilities[counter % names.count]
            program.probablilityNumber = probablilitiesNumbers[counter % names.count]
            counter += 1
            program.id = counter
            programs.append(program)
        }
    }
    
    func loadPrograms(since: EdProgram! = nil, didLoad:@escaping ([EdProgram]?) -> Void) {
        print("I AM IN loadPrograms")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
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
                        didLoad(nil)
                    }
            }
        }
    }
    
    func searchPrograms(searchString: String, since: EdProgram?, didFind:@escaping ([EdProgram]?) -> Void) {
        print("I AM IN searchPrograms")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            if searchString.isEmpty {
                didFind(self.programs)
            } else {
                didFind(self.programs.filter {
                    program in program.name.contains(searchString) || program.code.contains(searchString)
                })
            }
        }
    }
    
    func loadChosenPrograms(since: EdProgram!, didLoad: @escaping ([EdProgram]?) -> Void) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            didLoad(self.programs)
        }
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
//
//            let request = AF.request(EdProgramService.favoriteProgrammsURL, method: .get)
//
//            request.responseJSON { (response) in
//                switch response.result {
//                    case .success:
//                        print("response::: ", response.result)
//                        if let json = response.data {
//                            let jsonDecoder = JSONDecoder()
//                            let edPrograms = try! jsonDecoder.decode([EdProgram].self, from: json)
//                            didLoad(edPrograms)
//
//                        }
//                    case .failure(_):
//                        didLoad(nil)
//                    }
//            }
//        }
    }
}
