import Foundation
import UIKit

class PhotoTableViewPresenter: PhotoTableViewPresenterProtocol {

    weak var view: PhotoTableViewControllerProtocol!
    var interactor: PhotoTableViewInteractorProtocol!
    var router: PhotoTableViewRouterProtocol!
    var sectionsCount = 2
    

    func viewDidLoad() {}
    
    func getPhotos() ->[UIImage] {
        return interactor?.getPhotos() ?? []
    }
    
    func getSectionsCount() -> Int {
        return sectionsCount
    }
    
    func getNumberOfRowsInSection(section: Int) -> Int {
        if section == 0 {
            return interactor?.getPhotos().count ?? 0
        } else if section == 1 && interactor?.getIsFetching() ?? true {
            return 1
        }
        return 0
    }
    
    func calculateCellSize(photo: UIImage, frameWidth: CGFloat, section: Int) -> CGFloat {
        if section == 0 {
            return photo.getImageRatio() * frameWidth
        } else {
            return 40.0
        }
    }
    
    func checkScroll(scrollView: UIScrollView, starter: ()->(), completion: @escaping ()->()) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
    
        if offsetY > contentHeight - scrollView.frame.height {
            if !(interactor?.getIsFetching() ?? true) {
//                interactor?.fetchPhotos(starter: starter, completion: completion)
            }
        }
    }
    
    func openPhotoViewer (photo: UIImage) {
        router?.openPhotoViewer(photo: photo)
    }
}
