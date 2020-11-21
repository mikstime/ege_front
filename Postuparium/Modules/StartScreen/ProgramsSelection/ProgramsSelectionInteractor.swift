//
//  ProgramsSelectionInteractor.swift
//  Postuparium
//
//  Created by Сергей Петренко on 12.10.2020.
//

import Foundation
var counter = 0
let names = ["Материаловедение", "Математика", "Физика"]
let codes = ["11.0.1", "13.0.2", "14.2.12"]
class ProgramsSelectionInteractor: ProgramsSelectionInteractorProtocol {
    
    weak var presenter: ProgramsSelectionPresenterProtocol!
    
    var enrollee: Enrollee = Enrollee()
    
    func loadPrograms() {
        var programs: [EdProgram] = []
        for _ in 1...10 {
            var program = EdProgram()
            program.name = names[counter % names.count]
            program.code = codes[counter % names.count]
            counter += 1
            program.id = counter
            programs.append(program)
        }

        presenter.programsDidLoad(programs: programs)
    }
}
