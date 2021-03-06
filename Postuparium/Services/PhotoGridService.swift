//
//  PhotoGridService.swift
//  Postuparium
//
//  Created by user on 27.12.2020.
//

import Foundation
import UIKit
import Alamofire


protocol PhotoGridServiceProtocol {
    var photos: [UIImage] {get set}
    func fetchPhotos(university: University!, completion: @escaping ([UIImage])-> Void)
}

class PhotoGridService: PhotoGridServiceProtocol{
    static var universityURL: String = "http://77.223.97.172:8081/api/v1/universities/"
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
//            self.photos.append(image)
            completion(image)
        }
    }
    
    func fetchPhotos(university: University!, completion: @escaping ([UIImage])-> Void) {
        // тут должно быть получение большего числа фоток
        // сейчас здесь заглушка
        
//        let semaphore = DispatchSemaphore(value: 0)
        var counter = 0
        DispatchQueue.global(qos: .utility).async {
            self.loadPhotosFromNetwork(university: university, onLoad:  { photoStrings in
                var resultPhotos = [UIImage](repeating: UIImage(), count: photoStrings.count)

                for i in 0...photoStrings.count - 1 {
                    self.loadImage(url: photoStrings[i], completion: { photo in
//                        semaphore.wait()
                        resultPhotos[i] = photo
                        counter += 1
//                        if counter >= photoStrings.count - 1 {
//                            print(resultPhotos)
                        DispatchQueue.main.async{
                            completion(resultPhotos)
                        }
//                        }
//                        semaphore.signal()
                    })
                }

            })
        }
    }
    
    func loadPhotosFromNetwork(university: University!, onLoad: @escaping ([String]) -> Void) {
        if university == nil {
            onLoad(self.MOCK_PHOTOS)
            return
        }
        
        let finalURL = PhotoGridService.universityURL+String(university.id)+"/photos"
        
        let request = AF.request(finalURL, method: .get)
        
        request.responseJSON { (response) in
            switch response.result {
                case .success:
                    print("response::: ", response.result)
                    if let json = response.data {
                        let jsonDecoder = JSONDecoder()
                        let universityPhotos = try! jsonDecoder.decode([String].self, from: json)
                        
                        onLoad(universityPhotos)
                    }
                case .failure(_):
                    print("FAIL:: ", response.result)
                    onLoad(self.MOCK_PHOTOS)
                }
        }
    }
}
