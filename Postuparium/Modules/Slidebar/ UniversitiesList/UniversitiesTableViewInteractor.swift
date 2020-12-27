import Foundation
import UIKit

class UniversitiesTableViewInteractor: UniversitiesTableViewInteractorProtocol {
    weak var presenter: UniversitiesTableViewPresenterProtocol!
    private var isNext = true
    
    func getUniversities() -> [University] {
        return UniversitiesService.shared.universities
    }
    
    func getUniversitiesCount() -> Int {
        return UniversitiesService.shared.universities.count
    }
    
    func hasNext() -> Bool {
        return isNext
    }
    
    func fetch(callback: @escaping  () -> Void ) {
        UniversitiesService.shared.fetchUniversities(callback: callback)
    }
}
