//
//  HomeProgramsInteractor.swift
//  Postuparium
//
//  Created by Михаил on 26.12.2020.
//

import Foundation
import UIKit
protocol HomeProgramDispatcher: class {
    func programTapped(program: EdProgram)
}

class HomeProgramsInteractor: HomeProgramDispatcher {
    weak var view: HomePrograms!
    weak var dispatcher: HomeProgramDispatcher!
    func loadPrograms() {
        EdProgramService.shared.loadChosenPrograms(since: nil, university: view.university,didLoad: { programs in
            if let programs = programs {
                self.view?.programsAreLoaded(programs: programs)
            } else {
                self.view?.programsAreNotLoaded()
            }
        })
    }
    
    func programTapped(program: EdProgram) {
        dispatcher?.programTapped(program: program)
    }
}
