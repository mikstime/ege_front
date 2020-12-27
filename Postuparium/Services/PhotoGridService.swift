//
//  PhotoGridService.swift
//  Postuparium
//
//  Created by user on 27.12.2020.
//

import Foundation
import UIKit

protocol PhotoGridServiceProtocol {
    var photos: [UIImage] {get set}
    func fetchPhotos(completion: @escaping ()->())
}

class PhotoGridService: PhotoGridServiceProtocol{
    var photos: [UIImage] = []
    static var shared: PhotoGridServiceProtocol = PhotoGridService()
    
    func fetchPhotos(completion: @escaping ()->()) {
        // тут должно быть получение большего числа фоток
        // сейчас здесь заглушка
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
            if let photo_1 = UIImage(named: "8cebe4fdb0ce2ce1565312fa4e281596") {
                self.photos.append(photo_1)
            }
            if let photo_2 = UIImage(named: "vhod") {
                self.photos.append(photo_2)
            }
            if let photo_3 = UIImage(named: "700ba") {
                self.photos.append(photo_3)
            }
            if let photo_1 = UIImage(named: "8cebe4fdb0ce2ce1565312fa4e281596") {
                self.photos.append(photo_1)
            }
            if let photo_2 = UIImage(named: "vhod") {
                self.photos.append(photo_2)
            }
            if let photo_3 = UIImage(named: "700ba") {
                self.photos.append(photo_3)
            }
            completion()
        })
    }
}
