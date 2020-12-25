//
//  FeedbackService.swift
//  Postuparium
//
//  Created by Михаил on 22.11.2020.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol FeedbackServiceProtocol {
    static var shared: FeedbackServiceProtocol {get}
    
    func send(email: String, message: String, title: String, onFinish: @escaping (Bool) -> Void)
}

class FeedbackService: FeedbackServiceProtocol {
    static var LoginApiURL: String = "http://77.223.97.172:8080/api/v1/login/"
    static var UsersApiURL: String = "http://77.223.97.172:8080/api/v1/users/"
    
    static var shared: FeedbackServiceProtocol = FeedbackService()
    
    var enrollee: Enrollee = Enrollee()
    
    private init() {}
    
    func send(email: String, message: String, title: String, onFinish: @escaping (Bool) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            onFinish(true)
        }
    }
}

