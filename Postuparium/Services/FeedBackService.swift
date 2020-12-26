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
    static var FeedBackApiURL: String = "http://77.223.97.172:8080/api/v1/feedback/"
    
    static var shared: FeedbackServiceProtocol = FeedbackService()
    
    var enrollee: Enrollee = Enrollee()
    
    private init() {}
    
    func send(email: String, message: String, title: String, onFinish: @escaping (Bool) -> Void) {
//        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//            onFinish(true)
//        }
        let request = AF.request(FeedbackService.FeedBackApiURL, method: .post, parameters: [
            "email": email,
            "message": message,
            "title": title,
        ])
        
        request.responseJSON { (response) in
            switch response.result {
                case .success:
                    onFinish(true)
                case .failure(_):
                    onFinish(false)
                }
        }
    }
}

