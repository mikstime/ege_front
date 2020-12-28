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
    func fetchPhotos(completion: @escaping ([UIImage])-> Void)
}

class PhotoGridService: PhotoGridServiceProtocol{
    var photos: [UIImage] = []
    private var MOCK_PHOTOS = [
        "https://www.interfax.ru/ftproot/textphotos/2020/10/20/700ba.jpg",
        "https://ekd.me/wp-content/uploads/2019/02/img_52531-e1551272911192.jpg",
        "https://abiturient.bmstu.ru/assets/bg/start.jpg",
        "https://www.interfax.ru/ftproot/textphotos/2020/10/20/700ba.jpg",
        "https://ekd.me/wp-content/uploads/2019/02/img_52531-e1551272911192.jpg",
        "https://abiturient.bmstu.ru/assets/bg/start.jpg",
        "https://www.interfax.ru/ftproot/textphotos/2020/10/20/700ba.jpg",
        "https://ekd.me/wp-content/uploads/2019/02/img_52531-e1551272911192.jpg",
        "https://abiturient.bmstu.ru/assets/bg/start.jpg",
        "https://www.interfax.ru/ftproot/textphotos/2020/10/20/700ba.jpg",
        "https://ekd.me/wp-content/uploads/2019/02/img_52531-e1551272911192.jpg",
        "https://abiturient.bmstu.ru/assets/bg/start.jpg",
        "https://www.interfax.ru/ftproot/textphotos/2020/10/20/700ba.jpg",
        "https://ekd.me/wp-content/uploads/2019/02/img_52531-e1551272911192.jpg",
        "https://abiturient.bmstu.ru/assets/bg/start.jpg",
    ]
    static var shared: PhotoGridServiceProtocol = PhotoGridService()
    var useMocks = true
    func loadImage(url: String, completion: @escaping (UIImage)->()) {
        guard let imageURL = URL(string: url) else { return }
        
            guard let imageData = try? Data(contentsOf: imageURL) else { return }

            if let image = UIImage(data: imageData){
                self.photos.append(image)
                completion(image)
        }
    }
    
    func fetchPhotos(completion: @escaping ([UIImage])-> Void) {
        // тут должно быть получение большего числа фоток
        // сейчас здесь заглушка
        
//        let semaphore = DispatchSemaphore(value: 0)
        var counter = 0
        DispatchQueue.global(qos: .utility).async {
            self.loadPhotosFromNetwork { photoStrings in
                var resultPhotos = [UIImage](repeating: UIImage(), count: photoStrings.count)

                for i in 0...photoStrings.count - 1 {
                    self.loadImage(url: photoStrings[i], completion: { photo in
//                        semaphore.wait()
                        resultPhotos[i] = photo
                        counter += 1
                        if counter >= photoStrings.count - 1 {
                            print(resultPhotos)
                            DispatchQueue.main.async{
                                completion(resultPhotos)
                            }
                        }
//                        semaphore.signal()
                    })
                }

            }
        }
    }
    
    func loadPhotosFromNetwork(onLoad: @escaping ([String]) -> Void) {
        if useMocks {
            DispatchQueue.global(qos: .utility).asyncAfter(deadline: .now() + 1, execute: {
                onLoad(self.MOCK_PHOTOS)
            })
        } else {
            // ДИМА, ЗАПИЛИ ФОТКИ
        }
    }
}
