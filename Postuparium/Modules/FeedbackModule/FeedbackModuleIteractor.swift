//
//  FeedbackModuleIteractor.swift
//  Postuparium
//
//  Created by Сергей Петренко on 23.11.2020.
//

import Foundation

class FeedbackModuleInteractor: FeedbackModuleInteractorProtocol {
    
    weak var presenter: FeedbackModulePresenterProtocol!
    func send(email: String, message: String, title: String, onFinish: @escaping (Bool) -> Void) {
        FeedbackService.shared.send(email: email, message: message, title: title,
                                    onFinish: {status in onFinish(status)})
    }
    
}
