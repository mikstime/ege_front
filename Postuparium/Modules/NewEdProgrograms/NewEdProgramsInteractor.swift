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
        return []
    }
}
