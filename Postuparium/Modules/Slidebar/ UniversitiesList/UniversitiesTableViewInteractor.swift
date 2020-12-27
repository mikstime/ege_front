import Foundation
import UIKit

class UniversitiesTableViewInteractor: UniversitiesTableViewInteractorProtocol {
    weak var presenter: UniversitiesTableViewPresenterProtocol!
    
    private(set) var universities = [University]()
    private var isNext = true
    
    func getUniversities() -> [University] {
        return universities
    }
    
    func getUniversitiesCount() -> Int {
        return self.universities.count
    }
    
    func hasNext() -> Bool {
        return isNext
    }
    
    func fetch(callback: @escaping  () -> Void ) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
            if let photo = UIImage(named: "vhod") {
                self.universities.append(University(scores: 192, place: 52, rating: 5, name: "Мисис", image: photo))
                self.universities.append(University(scores: 210, place: 14, rating: 5, name: "МГУ", image: photo))
                self.universities.append(University(scores: 270, place: 13, rating: 5, name: "МГТУ", image: photo))
                self.universities.append(University(scores: 199, place: 100, rating: 5, name: "МФТИ", image: photo))
                self.universities.append(University(scores: 240, place: 99, rating: 5, name: "МИРЭА", image: photo))
                self.universities.append(University(scores: 260, place: 89, rating: 5, name: "МАИ", image: photo))
            }
            
            callback();
        });
    }
}
