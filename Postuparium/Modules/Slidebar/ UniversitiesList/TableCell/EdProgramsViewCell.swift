

import UIKit

class EdProgramsViewCell: UITableViewCell {
    
    var programs = HomePrograms()
    var grayGradient: CAGradientLayer!
    var dispatcher: HomeProgramDispatcher! {
        didSet {
            programs.interactor.dispatcher = dispatcher
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupGradient()
        self.contentView.addSubview(programs)
        NSLayoutConstraint(item: programs, attribute: .top, relatedBy: .equal, toItem: self.contentView, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: programs, attribute: .leading, relatedBy: .equal, toItem: self.contentView, attribute: .leading, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: programs, attribute: .trailing, relatedBy: .equal, toItem: self.contentView, attribute: .trailing, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: programs, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 214).isActive = true
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
        updateGrayGradient()
    }
    
    func updateGrayGradient() {
        grayGradient.colors = [UIColor(named: "GrayGradientTop")?.cgColor ?? #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1).cgColor, UIColor(named: "GrayGradientBottom")?.cgColor ?? #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1).cgColor]
    }
    
}
