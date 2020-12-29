
import UIKit

class PhotoViewerController: UIViewController, UIScrollViewDelegate, PhotoViewerControllerProtocol {
    @IBOutlet weak var viewerPhoto: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    
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
        
        //viewerPhoto.isUserInteractionEnabled = true
        self.scrollView.minimumZoomScale = 1.0
        self.scrollView.maximumZoomScale = 4.0
        self.scrollView.delegate = self
    }
        
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return viewerPhoto
    }
}
