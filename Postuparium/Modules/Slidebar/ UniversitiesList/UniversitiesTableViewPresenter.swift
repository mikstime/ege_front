import Foundation
import UIKit

class UniversitiesTableViewPresenter: UniversitiesTableViewPresenterProtocol {

    weak var view: UniversitiesTableViewControllerProtocol!
    var interactor: UniversitiesTableViewInteractorProtocol!
    var router: UniversitiesTableViewRouterProtocol!

    var pageIndex: Int = 0
    var hideHomePrograms: Bool = true
    
    func viewDidLoad() {}
    
    func fetch(callback: @escaping  () -> Void ){
        interactor?.fetch(callback: callback)
    }
    
    func getNumberOfRowsInSection() -> Int {
        return self.interactor!.hasNext() ? self.interactor!.getUniversitiesCount() + 1 : self.interactor!.getUniversitiesCount()
    }
    
    func isEndCell(indexPath: IndexPath) -> Bool {
        return self.interactor!.hasNext() && indexPath.row == self.interactor!.getUniversitiesCount()
    }
 
    func setCellData(cell: UniversityTableViewCell, indexPath: IndexPath){
        cell.university = interactor!.getUniversities()[indexPath.row]
    }
    
    func getCellData(indexPath: IndexPath) -> University {
        return interactor!.getUniversities()[indexPath.row]
    }
    
    func showProgram(program: EdProgram) {
        router?.showProgram(program: program)
    }
}
