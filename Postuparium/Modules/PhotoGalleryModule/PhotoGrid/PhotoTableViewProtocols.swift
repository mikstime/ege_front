import Foundation
import UIKit

protocol PhotoTableViewControllerProtocol: UITableViewController {
    var presenter: PhotoTableViewPresenterProtocol! {get set}
    var university: University! {get set}
}

protocol PhotoTableViewPresenterProtocol: class {
    var router: PhotoTableViewRouterProtocol! { set get }
    var view: PhotoTableViewControllerProtocol! {set get}
    var interactor: PhotoTableViewInteractorProtocol! {get set}
    func viewDidLoad()
    func getPhotos() ->[UIImage] 
    func getSectionsCount() -> Int
    func getNumberOfRowsInSection(section: Int) -> Int
    func calculateCellSize(photo: UIImage, frameWidth: CGFloat, section: Int) -> CGFloat
    func checkScroll(scrollView: UIScrollView, starter: ()->(), completion: @escaping ()->())
    func openPhotoViewer (photo: UIImage)
}

protocol PhotoTableViewInteractorProtocol: class {
    var photos: [UIImage] {get set}
    var presenter: PhotoTableViewPresenterProtocol! {get set}
    func getPhotos() -> [UIImage]
    func getIsFetching() -> Bool
    func fetchPhotos(starter: ()->(), completion: @escaping ([UIImage]) -> Void)
}

protocol PhotoTableViewRouterProtocol: class {
    var view: PhotoTableViewControllerProtocol! {set get}
    func prepare(for segue: UIStoryboardSegue, sender: Any?)
    func openPhotoViewer(photo: UIImage)
}

protocol PhotoTableViewConfiguratorProtocol: class {
    static func configureModule() -> PhotoTableViewControllerProtocol
}
