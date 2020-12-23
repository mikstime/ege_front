import Foundation
import UIKit

class UniversitiesTableViewConfigurator: UniversitiesTableViewConfiguratorProtocol {
    
    static func configureModule() -> UniversitiesTableViewControllerProtocol {
        
        let viewController = UniversitiesTableViewController(nibName: "UniversitiesTableViewController", bundle: nil)
        
        let presenter = UniversitiesTableViewPresenter()
        let interactor = UniversitiesTableViewInteractor()
        let router = UniversitiesTableViewRouter()
        
        //interactor.photos = []
        
        viewController.presenter = presenter
        interactor.presenter = presenter
        
        router.view = viewController
        
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router

        return viewController
    }
}
