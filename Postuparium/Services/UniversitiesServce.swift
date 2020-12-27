//
//  UniversitiesServce.swift
//  Postuparium
//
//  Created by user on 27.12.2020.
//

import Foundation
import UIKit


protocol UniversitiesServiceProtocol {
    var universities: [University] {get set}
    func fetchUniversities(callback: @escaping  () -> Void )
}

class UniversitiesService: UniversitiesServiceProtocol{
    var universities = [University]()
    static var shared: UniversitiesServiceProtocol = UniversitiesService()
    
    func fetchUniversities(callback: @escaping  () -> Void ) {
        //  заглушка для подгрузки университетов
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
            if let photo = UIImage(named: "vhod") {
                self.universities.append(University(scores: 192, place: 52, rating: 5, name: "Мисис", image: photo))
                self.universities.append(University(scores: 210, place: 14, rating: 5, name: "МГУ", image: photo))
                self.universities.append(University(scores: 270, place: 13, rating: 5, name: "МГТУ", image: photo))
                self.universities.append(University(scores: 199, place: 100, rating: 5, name: "МФТИ", image: photo))
                self.universities.append(University(scores: 240, place: 99, rating: 5, name: "МИРЭА", image: photo))
                self.universities.append(University(scores: 260, place: 89, rating: 5, name: "МАИ", image: photo))
            }
            callback();
        });
    }
}
