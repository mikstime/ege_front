
import UIKit

class PhotoViewerController: UIViewController, PhotoViewerControllerProtocol {
    @IBOutlet weak var viewerPhoto: UIImageView!
    var presenter: PhotoViewerPresenterProtocol!
    
    var photo: UIImage? {
        didSet {
            viewerPhoto.image = photo
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        
        viewerPhoto.layer.shadowColor = UIColor(named: "Shadow")?.cgColor ?? UIColor.label.cgColor
        viewerPhoto.layer.shadowOpacity = 0.16
        viewerPhoto.layer.shadowOffset = .zero
        viewerPhoto.layer.shadowRadius = 6
    }
}
