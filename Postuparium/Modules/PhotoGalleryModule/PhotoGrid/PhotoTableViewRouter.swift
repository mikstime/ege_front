import Foundation
import UIKit

class PhotoTableViewRouter: PhotoTableViewRouterProtocol {
    weak var view: PhotoTableViewControllerProtocol!
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // prepare here some data for destination viewController
    }
    
    func openPhotoViewer(photo: UIImage) {
        let vc = PhotoViewerConfigurator.configureModule(photo: photo)
        view?.navigationController!.show(vc, sender: view)
    }
    
}
