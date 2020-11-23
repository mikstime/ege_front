//
//  EgeResultsSelectionInteractor.swift
//  Postuparium
//
//  Created by Сергей Петренко on 12.10.2020.
//

import Foundation

// 1. интерактор
struct SubjectDetails {
    var id: Int
    var score: Int
    var name: String = ""
}
class EgeResultsSelectionInteractor: EgeResultsSelectionInteractorProtocol {
    weak var presenter: EgeResultsSelectionPresenterProtocol!
    
    var enrollee: Enrollee = Enrollee()
    
    func getEnrollee() -> Enrollee {
        return enrollee
    }
    func getSubjectsList() -> [String] {
        return ["Русский язык", "Математика", "Физика",
                "Химия", "История", "Обществознание", "ИКТ", "Биология",
                "География", "Английский зык", "Немецкий язык", "Французский язык",
                "Китайский язык", "Испанский язык", "Литература"]
    }
    
    func onError() {
        //nop
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

extension EgeResultsSelectionInteractor {
    
    func updateEnrolleeSubjects(subjects: [SubjectDetails]) {
        for subject in subjects {
            _updateSubjectById(id: subject.id, score: subject.score)
        }
        EnrolleeService.shared.setEgeResults(egeResults: enrollee.egeResults)
    }
    
    private func _updateSubjectById(id: Int, score: Int) {
        
        switch id {
        case 0: enrollee.egeResults.russian = score; break
        case 1: enrollee.egeResults.mathProf = score; break
        case 2: enrollee.egeResults.physics = score; break
        case 3: enrollee.egeResults.chemistry = score; break
        case 4: enrollee.egeResults.history = score; break
        case 5: enrollee.egeResults.socialStudies = score; break
        case 6: enrollee.egeResults.informatics = score; break
        case 7: enrollee.egeResults.biology = score; break
        case 8: enrollee.egeResults.geography = score; break
        case 9: enrollee.egeResults.english = score; break
        case 10: enrollee.egeResults.german = score; break
        case 11: enrollee.egeResults.french = score; break
        case 12: enrollee.egeResults.chinese = score; break
        case 13: enrollee.egeResults.spanish = score; break
        case 14: enrollee.egeResults.literature = score; break
        default: break
        }
    }
    
}
