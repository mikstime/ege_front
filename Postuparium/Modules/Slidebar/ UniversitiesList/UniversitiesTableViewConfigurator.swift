import Foundation
import UIKit

class UniversitiesTableViewConfigurator: UniversitiesTableViewConfiguratorProtocol {
    
    static func configureModule(hideHomePrograms: Bool) -> UniversitiesTableViewControllerProtocol {
        
        let viewController = UniversitiesTableViewController(nibName: "UniversitiesTableViewController", bundle: nil)
        
        let presenter = UniversitiesTableViewPresenter()
        let interactor = UniversitiesTableViewInteractor()
        let router = UniversitiesTableViewRouter()
        
        viewController.presenter = presenter
        interactor.presenter = presenter
        
        router.view = viewController
        
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router
        presenter.hideHomePrograms = hideHomePrograms

        return viewController
    }
}
