
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
        
        navigationController?.navigationBar.setBackgroundImage(nil, for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = nil
        
        viewerPhoto.isUserInteractionEnabled = true
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(self.pinchGesture))
        viewerPhoto.addGestureRecognizer(pinchGesture)
    }
    
    @objc func pinchGesture(sender: UIPinchGestureRecognizer) {
        if let scale = (sender.view?.transform.scaledBy(x: sender.scale, y: sender.scale)) {
            guard scale.a > 1.0 else {return}
            guard scale.d > 1.0 else {return}
            sender.view?.transform = scale
            sender.scale = 1.0
        }
    }
}
