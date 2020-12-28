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
    
    func loadImage(url: String, completion: @escaping ()->()) {
        guard let imageURL = URL(string: url) else { return }
        DispatchQueue.global(qos: .utility).async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }

            if let image = UIImage(data: imageData){
                self.photos.append(image)
                DispatchQueue.main.sync {
                    completion()
                }
            }
        }
    }
    
    func fetchPhotos(completion: @escaping ()->()) {
        // тут должно быть получение большего числа фоток
        // сейчас здесь заглушка
        
        DispatchQueue.global(qos: .utility).async {
            self.loadImage(url: "https://www.interfax.ru/ftproot/textphotos/2020/10/20/700ba.jpg", completion: completion)
            self.loadImage(url: "https://ekd.me/wp-content/uploads/2019/02/img_52531-e1551272911192.jpg", completion: completion)
            self.loadImage(url: "https://abiturient.bmstu.ru/assets/bg/start.jpg", completion: completion)
        
            self.loadImage(url: "https://www.interfax.ru/ftproot/textphotos/2020/10/20/700ba.jpg", completion: completion)
            self.loadImage(url: "https://ekd.me/wp-content/uploads/2019/02/img_52531-e1551272911192.jpg", completion: completion)
            self.loadImage(url: "https://abiturient.bmstu.ru/assets/bg/start.jpg", completion: completion)
            
            self.loadImage(url: "https://www.interfax.ru/ftproot/textphotos/2020/10/20/700ba.jpg", completion: completion)
            self.loadImage(url: "https://ekd.me/wp-content/uploads/2019/02/img_52531-e1551272911192.jpg", completion: completion)
            self.loadImage(url: "https://abiturient.bmstu.ru/assets/bg/start.jpg", completion: completion)
            
            self.loadImage(url: "https://www.interfax.ru/ftproot/textphotos/2020/10/20/700ba.jpg", completion: completion)
            self.loadImage(url: "https://ekd.me/wp-content/uploads/2019/02/img_52531-e1551272911192.jpg", completion: completion)
            self.loadImage(url: "https://abiturient.bmstu.ru/assets/bg/start.jpg", completion: completion)
        }
    }
}
