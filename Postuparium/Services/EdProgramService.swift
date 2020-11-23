//
//  EdProgramService.swift
//  Postuparium
//
//  Created by Михаил on 22.11.2020.
//

import Foundation

protocol EdProgramServiceProtocol {
    static var shared: EdProgramServiceProtocol {get}
    func loadPrograms(since: EdProgram!, didLoad:@escaping ([EdProgram]?) -> Void)
    func searchPrograms(searchString: String, since: EdProgram?, didFind:@escaping ([EdProgram]?) -> Void)
}

class EdProgramService: EdProgramServiceProtocol {
    var programs: [EdProgram] = []
    let names = ["Материаловедение", "Математика", "Физика"]
    let codes = ["11.0.1", "13.0.2", "14.2.12"]
    var counter = 0
    static var shared: EdProgramServiceProtocol = EdProgramService()
    
    private init() {
        for _ in 1...10 {
            var program = EdProgram()
            program.name = names[counter % names.count]
            program.code = codes[counter % names.count]
            counter += 1
            program.id = counter
            programs.append(program)
        }
    }
    
    func loadPrograms(since: EdProgram! = nil, didLoad:@escaping ([EdProgram]?) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            didLoad([self.programs[0]])
        }
    }
    
    func searchPrograms(searchString: String, since: EdProgram?, didFind:@escaping ([EdProgram]?) -> Void) {
        print(searchString)
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
}

