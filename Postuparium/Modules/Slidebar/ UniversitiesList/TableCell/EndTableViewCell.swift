import UIKit

class EndTableViewCell: UITableViewCell {

    @IBOutlet weak var nextLabel: UILabel!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.loader(animate: false)
    }
    
    func loader(animate: Bool) {
        self.loader.isHidden = !animate
        self.nextLabel.isHidden = animate
        
        animate ? self.loader.startAnimating() : self.loader.stopAnimating()
    }
}
