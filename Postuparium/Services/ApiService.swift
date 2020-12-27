//
//  ApiService.swift
//  Postuparium
//
//  Created by Сергей Петренко on 12.10.2020.
//

import Foundation


class ApiService: ApiServiceProtocol {
    
    // MARK: - ApiServiceProtocol methods
    
func openUrl(with urlString: String) {
    }
    
    // MARK: - Private methods
        
    private func getJSON(URL: URL, completion: @escaping ([String: Any]?, Error?) -> Swift.Void) {
        let sharedSession = URLSession.shared
        
        let dataTask = sharedSession.dataTask(with: URL, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                print("Error to load: \(String(describing: error?.localizedDescription))")
                completion(nil, error)
                return
            }
            
            if let dataResponse = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: dataResponse, options: []) as! [String: AnyObject]
                    
                    print("json: \(json), error: \(String(describing: error))")
                    completion(json, nil)
                    return
                    
                } catch let error as NSError {
                    
                    print("Failed to load: \(error.localizedDescription)")
                    completion(nil, error)
                }
            }
        })
        dataTask.resume()
    }
    
}
