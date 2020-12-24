//
//  Universities.swift
//  Postuparium
//
//  Created by d.boldin on 23/12/20.
//

import Foundation
import Alamofire


protocol UniversityServiceProtocol {
    func getAllUniverstities(u:@escaping ([University]?) -> Void)
}

class UniversityService: UniversityServiceProtocol {
    static var GetURL: String = "http://77.223.97.172:8080/api/v1/universities/"
    
    
    func getAllUniverstities(u:@escaping ([University]?) -> Void) {
        
        let request = AF.request(UniversityService.GetURL, method: .get, encoding: JSONEncoding.default)
        
        request.responseJSON { (response) in
            switch response.result {
                case .success:
                    if let json = response.data {
                        print(json, type(of:json))
                        
                        u(nil)
                    }
                case .failure(_):
                    u(nil)
                }
        }
    
    }
}
