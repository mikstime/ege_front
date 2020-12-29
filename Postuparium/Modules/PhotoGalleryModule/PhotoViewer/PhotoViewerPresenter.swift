
import Foundation
import UIKit

class PhotoViewerPresenter: PhotoViewerPresenterProtocol {

    weak var view: PhotoViewerControllerProtocol!
    var interactor: PhotoViewerInteractorProtocol!
    var router: PhotoViewerRouterProtocol!

    func viewDidLoad() {
        if let photo = interactor?.photo {
            view.photo = photo
        }
    }
}
