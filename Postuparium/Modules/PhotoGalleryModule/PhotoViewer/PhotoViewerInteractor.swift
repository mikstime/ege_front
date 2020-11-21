import Foundation
import UIKit

class PhotoViewerInteractor: PhotoViewerInteractorProtocol {
    weak var presenter: PhotoViewerPresenterProtocol!
    var photo: UIImage?
}

