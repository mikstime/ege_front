

import UIKit

class UniversityTableViewCell: UITableViewCell {
    @IBOutlet weak var imageUniversity: UIImageView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var scoresLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var opacityLayerView: UIView!
    
    
    var university: University? {
        didSet {
            self.setUniversityData(university: university!)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.roundImage()
    }
    
    func setImage(image: UIImage) {
        self.imageUniversity.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        self.imageUniversity.isOpaque = false
        //self.imageUniversity.alpha = 0.8
        self.imageUniversity.image = image
    }
    
    func setOpacityLayer(){
        self.opacityLayerView.backgroundColor = UIColor.black
        self.opacityLayerView.isOpaque = true
        self.opacityLayerView.alpha = 0.5
        self.opacityLayerView.layer.cornerRadius = 15
        self.opacityLayerView.layer.masksToBounds = true
    }
    
    func setUniversityData(university: University){
        self.placeLabel.text = String(university.place)
        self.scoresLabel.text = String(university.scores)
        self.ratingLabel.text = String(university.rating)
        self.nameLabel.text = university.name
        self.loadImage(image: university.image)
        self.setOpacityLayer()
    }
    
    private func roundImage() {
        self.imageUniversity.layer.cornerRadius = 15
        self.imageUniversity.layer.masksToBounds = true
        self.imageUniversity.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    public func loadImage(image: UIImage) -> Void {
        self.setImage(image: image)
        self.imageUniversity.backgroundColor = self.backgroundColor
    }
    
}
