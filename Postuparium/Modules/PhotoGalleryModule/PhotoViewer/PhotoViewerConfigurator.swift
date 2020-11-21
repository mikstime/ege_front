
import Foundation
import UIKit

class PhotoViewerConfigurator: PhotoViewerConfiguratorProtocol {
    
    static func configureModule(photo: UIImage) -> PhotoViewerControllerProtocol {
        
        let storyboard = UIStoryboard(name: "PhotoViewer", bundle: nil)
        guard let vc: UIViewController = storyboard.instantiateInitialViewController()
        else {
            print("Root contoller was not found in PhotoViewer storyboard")
            return PhotoViewerController()
        }
        
        let viewController = vc as! PhotoViewerControllerProtocol
        
        let presenter = PhotoViewerPresenter()
        let interactor = PhotoViewerInteractor()
        let router = PhotoViewerRouter()
        
        interactor.photo = photo
        
        viewController.presenter = presenter
        interactor.presenter = presenter
        
        router.view = viewController
        
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router

        return viewController
    }
}
