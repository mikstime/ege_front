import UIKit

class PhotoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var photoView: UIImageView!
    
    
    var photo: UIImage? {
        didSet {
            updateUI()
        }
    }
    
    final override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
            super.traitCollectionDidChange(previousTraitCollection)

            guard UIApplication.shared.applicationState == .inactive else {
                return
            }

        shadowView.layer.shadowColor = UIColor(named: "Shadow")?.cgColor ?? UIColor.label.cgColor
        }
    
    func updateUI() {
        photoView.image = photo
        photoView.layer.cornerRadius = 15.0
        photoView.layer.masksToBounds = true
        
        shadowView.layer.cornerRadius = 15.0
        shadowView.layer.shadowColor = UIColor(named: "Shadow")?.cgColor ?? UIColor.label.cgColor
        shadowView.layer.shadowOpacity = 0.16
        shadowView.layer.shadowOffset = .zero
        shadowView.layer.shadowRadius = 6
    }
}
