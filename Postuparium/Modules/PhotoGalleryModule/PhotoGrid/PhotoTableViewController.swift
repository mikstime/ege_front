import Foundation
import UIKit

class PhotoTableViewController: UITableViewController, PhotoTableViewControllerProtocol {
    
    var presenter: PhotoTableViewPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        navigationController?.navigationBar.setBackgroundImage(nil, for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = nil
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return presenter?.getSectionsCount() ?? 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.getNumberOfRowsInSection(section: section) ?? 0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let photo = presenter!.getPhotos()[indexPath.row]
        presenter?.openPhotoViewer(photo: photo)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ImageCell", for: indexPath) as! PhotoTableViewCell
                cell.photo = presenter!.getPhotos()[indexPath.row]
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LoadCell", for: indexPath) as! LoadTableViewCell
            cell.spinner.startAnimating()
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            let photos = presenter?.getPhotos() ?? []
            return presenter?.calculateCellSize(photo: photos[indexPath.row], frameWidth: tableView.frame.width, section: indexPath.section) ?? 40.0
        } else {
            return 40.0
        }
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        presenter?.checkScroll(scrollView: scrollView, starter: {tableView.reloadSections(IndexSet(integer: 1), with: .none)}, completion: tableView.reloadData)
    }
    
}
