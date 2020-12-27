import Foundation
import UIKit

class PhotoTableViewConfigurator: PhotoTableViewConfiguratorProtocol {
    
    static func configureModule() -> PhotoTableViewControllerProtocol {
        
        let storyboard = UIStoryboard(name: "PhotoTableView", bundle: nil)
        guard let vc: UITableViewController = storyboard.instantiateInitialViewController()
        else {
            print("Root contoller was not found in PhotoTableView storyboard")
            return PhotoTableViewController()
        }
        
        let viewController = vc as! PhotoTableViewControllerProtocol
        
        let presenter = PhotoTableViewPresenter()
        let interactor = PhotoTableViewInteractor()
        let router = PhotoTableViewRouter()
        
        viewController.presenter = presenter
        interactor.presenter = presenter
        
        router.view = viewController
        
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router

        return viewController
    }
}
