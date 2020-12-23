import Foundation
import UIKit

protocol UniversitiesTableViewControllerProtocol: UIViewController {
    var presenter: UniversitiesTableViewPresenterProtocol! {get set}
}

protocol UniversitiesTableViewPresenterProtocol: class {
    var router: UniversitiesTableViewRouterProtocol! { set get }
    var view: UniversitiesTableViewControllerProtocol! {set get}
    func fetch(callback: @escaping  () -> Void )
    func getNumberOfRowsInSection() -> Int
    func isEndCell(indexPath: IndexPath) -> Bool
    func setCellData(cell: UniversityTableViewCell, indexPath: IndexPath)
}

protocol UniversitiesTableViewInteractorProtocol: class {
    var presenter: UniversitiesTableViewPresenterProtocol! {get set}
    func getUniversities() -> [University]
    func getUniversitiesCount() -> Int
    func hasNext() -> Bool
    func fetch(callback: @escaping  () -> Void )
}

protocol UniversitiesTableViewRouterProtocol: class {
    var view: UniversitiesTableViewControllerProtocol! {set get}
}

protocol UniversitiesTableViewConfiguratorProtocol: class {
    static func configureModule() -> UniversitiesTableViewControllerProtocol
}
