
import UIKit

extension UIImage {
    func getImageRatio() -> CGFloat {
        let imageRatio = CGFloat(self.size.height / self.size.width)
        return imageRatio
    }
}
