import Foundation
import UIKit

class UniversitiesTableViewRouter: UniversitiesTableViewRouterProtocol {
    weak var view: UniversitiesTableViewControllerProtocol!
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // prepare here some data for destination viewController
    }
    
    func showProgram(program: EdProgram) {
        let vc = NewEdProgramModuleConfigurator.configureModule()
        view?.navigationController?.show(vc, sender: view)
    }
}
