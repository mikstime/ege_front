import UIKit

class EndTableViewCell: UITableViewCell {

    @IBOutlet weak var nextLabel: UILabel!
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var imageV: UIImageView!
    var grayGradient: CAGradientLayer!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.roundImage()
        self.setupGradient()
    }
    
    final override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        guard UIApplication.shared.applicationState == .inactive else {
            return
        }
        updateGrayGradient()
    }
    
    func setupGradient() {
        grayGradient = CAGradientLayer()
        grayGradient.frame.size = frame.size
        grayGradient.startPoint = .init(x: 0.5, y: 0)
        grayGradient.endPoint = .init(x: 0.5, y: 1)
        grayGradient.locations = [0.0, 1.0]
        imageV.layer.insertSublayer(grayGradient, at: 0)
        updateGrayGradient()
    }
    
    func updateGrayGradient() {
        grayGradient.colors = [UIColor(named: "GrayGradientTop")?.cgColor ?? #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1).cgColor, UIColor(named: "GrayGradientBottom")?.cgColor ?? #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1).cgColor]
    }
    
    private func roundImage() {
        imageV.layer.cornerRadius = 21
        imageV.layer.masksToBounds = true
        imageV.layer.borderColor = UIColor.lightGray.cgColor
    }


}
