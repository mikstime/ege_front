import Foundation
import UIKit

protocol PhotoViewerControllerProtocol: UIViewController {
    var presenter: PhotoViewerPresenterProtocol! {get set}
    var photo: UIImage? {get set}
}

protocol PhotoViewerPresenterProtocol: class {
    var router: PhotoViewerRouterProtocol! { set get }
    var view: PhotoViewerControllerProtocol! {set get}
    func viewDidLoad()
}

protocol PhotoViewerInteractorProtocol: class {
    var presenter: PhotoViewerPresenterProtocol! {get set}
    var photo: UIImage? {get set}
}

protocol PhotoViewerRouterProtocol: class {
    var view: PhotoViewerControllerProtocol! {set get}
    func prepare(for segue: UIStoryboardSegue, sender: Any?)
}

protocol PhotoViewerConfiguratorProtocol: class {
    static func configureModule(photo: UIImage) -> PhotoViewerControllerProtocol
}
