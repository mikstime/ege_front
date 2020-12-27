//
//  HomeProgramsInteractor.swift
//  Postuparium
//
//  Created by Михаил on 26.12.2020.
//

import Foundation

class HomeProgramsInteractor {
    weak var view: HomePrograms!
    
    func loadPrograms() {
        EdProgramService.shared.loadChosenPrograms(since: nil, didLoad: { programs in
            if let programs = programs {
                self.view?.programsAreLoaded(programs: programs)
            } else {
                self.view?.programsAreNotLoaded()
            }
        })
    }
}
