
import Foundation
import UIKit

class PhotoViewerRouter: PhotoViewerRouterProtocol {
    weak var view: PhotoViewerControllerProtocol!
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // prepare here some data for destination viewController
    }
}
