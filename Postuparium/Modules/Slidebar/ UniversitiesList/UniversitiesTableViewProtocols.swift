import Foundation
import UIKit

protocol UniversitiesTableViewControllerProtocol: UIViewController {
    var presenter: UniversitiesTableViewPresenterProtocol! {get set}
    var dispatcher: UniversitiesTableViewControllerDispatcher! {get set}
}

protocol UniversitiesTableViewPresenterProtocol: class {
    var router: UniversitiesTableViewRouterProtocol! {set get}
    var view: UniversitiesTableViewControllerProtocol! {set get}
    var hideHomePrograms: Bool {set get}
    func getCellData(indexPath: IndexPath) -> University
    func fetch(callback: @escaping  () -> Void )
    func search(query: String, callback: @escaping  () -> Void )
    func getNumberOfRowsInSection() -> Int
    func isEndCell(indexPath: IndexPath) -> Bool
    func setCellData(cell: UniversityTableViewCell, indexPath: IndexPath)
    
    func showProgram(program: EdProgram)
}

protocol UniversitiesTableViewInteractorProtocol: class {
    var presenter: UniversitiesTableViewPresenterProtocol! {get set}
    func getUniversities() -> [University]
    func getUniversitiesCount() -> Int
    func hasNext() -> Bool
    func fetch(callback: @escaping  () -> Void )
    func search(query: String, callback: @escaping  () -> Void )
}

protocol UniversitiesTableViewRouterProtocol: class {
    var view: UniversitiesTableViewControllerProtocol! {set get}
    func showProgram(program: EdProgram)
}

protocol UniversitiesTableViewConfiguratorProtocol: class {
    static func configureModule(hideHomePrograms: Bool) -> UniversitiesTableViewControllerProtocol
}
