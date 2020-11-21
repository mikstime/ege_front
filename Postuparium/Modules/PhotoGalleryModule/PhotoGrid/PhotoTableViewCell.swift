import UIKit

class PhotoTableViewCell: UITableViewCell {
    @IBOutlet weak var cellPhoto: UIImageView!
    
    var photo: UIImage? {
        didSet {
            updateUI()
        }
    }
    
    func updateUI() {
        cellPhoto.image = photo
        cellPhoto.layer.cornerRadius = 5.0
        cellPhoto.layer.masksToBounds = true
        cellPhoto.layer.shadowColor = UIColor(named: "Shadow")?.cgColor ?? UIColor.label.cgColor
        cellPhoto.layer.shadowOpacity = 0.16
        cellPhoto.layer.shadowOffset = .zero
        cellPhoto.layer.shadowRadius = 6
    }
}
