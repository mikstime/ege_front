//
//  NewEdProgramsInteractor.swift
//  Postuparium
//
//  Created by Сергей Петренко on 24.12.2020.
//

import Foundation

class NewEdProgramsInteractor: NewEdProgramsInteractorProtocol {
    
    weak var presenter: NewEdProgramsPresenterProtocol!
    
    func loadPrograms() -> [EdProgram]{
        EdProgramService.shared.searchPrograms(searchString: "", university: presenter.view.university, since: nil, didFind: {programs in
            self.presenter.view.edPrograms = programs ?? []
        })
        return []
    }
}
