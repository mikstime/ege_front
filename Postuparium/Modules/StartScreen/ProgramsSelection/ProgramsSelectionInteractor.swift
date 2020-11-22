//
//  ProgramsSelectionInteractor.swift
//  Postuparium
//
//  Created by Сергей Петренко on 12.10.2020.
//

import Foundation

class ProgramsSelectionInteractor: ProgramsSelectionInteractorProtocol {
    
    weak var presenter: ProgramsSelectionPresenterProtocol!
    
    var enrollee: Enrollee = Enrollee()
    var lastProgram: EdProgram!
    
    func searchForPrograms(searchString: String) {
        EdProgramService.shared.searchPrograms(searchString: searchString, since: lastProgram, didFind: {programs in
            if programs != nil {
                self.lastProgram = programs!.last
                self.presenter?.programsDidLoad(programs: programs!)
            } else {
                self.presenter?.programsDidLoad(programs: [])
            }
        })
    }
    func setPrograms(programs: [EdProgram]) {
        enrollee.chosenPrograms = programs
        EnrolleeService.shared.setChosenPrograms(programs: programs)
    }
    func tryToCreateUser() {
        EnrolleeService.shared.signup(didSignUp: {enrolleeDetails in
            if enrolleeDetails != nil {
                self.presenter?.didCreateUser()
            } else {
                self.presenter?.didNotCreateUser()
            }
        })
    }
}
