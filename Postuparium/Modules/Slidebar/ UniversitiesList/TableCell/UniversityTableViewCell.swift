

import UIKit

class UniversityTableViewCell: UITableViewCell {
    @IBOutlet weak var imageUniversity: UIImageView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var scoresLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    var gradient: CAGradientLayer!
    var grayGradient: CAGradientLayer!
    
    var university: University? {
        didSet {
            self.setUniversityData(university: university!)
        }
    }
    
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
        imageUniversity.layer.insertSublayer(grayGradient, at: 0)
        updateGrayGradient()
    }
    
    func updateGrayGradient() {
        grayGradient.colors = [UIColor(named: "GrayGradientTop")?.cgColor ?? #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1).cgColor, UIColor(named: "GrayGradientBottom")?.cgColor ?? #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1).cgColor]
    }
    
    func setUniversityData(university: University){
        self.placeLabel.text = String(university.place)
        self.scoresLabel.text = String(university.scores)
        self.ratingLabel.text = String(university.rating)
        self.nameLabel.text = university.name
//        self.loadImage(image: university.image)
        self.setImage(from: university.image)
    }
    
    private func roundImage() {
        self.imageUniversity.layer.cornerRadius = 21
        self.imageUniversity.layer.masksToBounds = true
        self.imageUniversity.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    public func loadImage(image: UIImage) -> Void {
        self.imageUniversity.image = image
        self.imageUniversity.backgroundColor = self.backgroundColor
    }
    func setImage(from url: String) {
        guard let imageURL = URL(string: url) else { return }

        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }

            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                self.imageUniversity?.image = image
            }
        }
    }
}
