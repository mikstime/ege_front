//
//  EgeResultsSelectionInteractor.swift
//  Postuparium
//
//  Created by Сергей Петренко on 12.10.2020.
//

import Foundation

// 1. интерактор
class EgeResultsSelectionInteractor: EgeResultsSelectionInteractorProtocol {
    var presenter: EgeResultsSelectionPresenterProtocol!
    
    
    func getSubjectsList() -> [String] {
        return ["Русский язык", "Математика", "Физика",
                "Химия", "История", "Обществознание", "ИКТ", "Биология",
                "География", "Английский зык", "Немецкий язык", "Французский язык",
                "Китайский язык", "Испанский язык", "Литература"]
    }
    
    func updateEnrolleeSubjects() {
        //nop
    }
    
    func onError() {
        //nop
    }
    
    func tryToCreateUser() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.presenter?.didCreateUser()
        }

    }
    
}
