import Foundation
import UIKit

class UniversitiesTableViewInteractor: UniversitiesTableViewInteractorProtocol {
    weak var presenter: UniversitiesTableViewPresenterProtocol!
    private var isNext = true
    
    func getUniversities() -> [University] {
        return []
//        return UniversitiesService.shared.universities
    }
    
    func getUniversitiesCount() -> Int {
        return 0
//        return UniversitiesService.shared.universities.count
    }
    
    func hasNext() -> Bool {
        return isNext
    }
    
    func fetch(callback: @escaping  () -> Void ) {
//        UniversitiesService.shared.fetchUniversities(callback: callback)
    }
    
    func search(query: String, callback: @escaping () -> Void) {
//        UniversitiesService.shared.searchUniversities(query: query,callback: callback)
    }
}
