import UIKit

class PhotoTableViewCell: UITableViewCell {
    @IBOutlet weak var cellPhoto: UIImageView!
    
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

            self.layer.shadowColor = UIColor(named: "Shadow")?.cgColor ?? UIColor.label.cgColor
        }
    
    func updateUI() {
        cellPhoto.image = photo
        cellPhoto.layer.cornerRadius = 15.0
        cellPhoto.layer.masksToBounds = true
    }
}
