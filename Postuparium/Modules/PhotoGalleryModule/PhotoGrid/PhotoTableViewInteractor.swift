import Foundation
import UIKit

class PhotoTableViewInteractor: PhotoTableViewInteractorProtocol {
    
    weak var presenter: PhotoTableViewPresenterProtocol!
    
    var photos: [UIImage] = []
    var sectionsCount = 2
    var isFetching = false
    
    func getPhotos() -> [UIImage] {
        return photos
    }
    
    func getIsFetching() -> Bool {
        return isFetching
    }
    
    func fetchPhotos(starter: ()->(), completion: @escaping ()->()) {
        self.isFetching = true
        starter()
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
            self.isFetching = false
            completion()
        })
    }
}
