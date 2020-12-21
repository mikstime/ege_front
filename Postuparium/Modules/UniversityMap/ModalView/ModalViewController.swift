//
//  ModalViewController.swift
//  Postuparium
//
//  Created by Сергей Петренко on 19.12.2020.
//

import Foundation

import UIKit

struct University {
    var label: String
    var bgImage: String
}

extension UIImageView {

 public func imageFromServerURL(urlString: String, PlaceHolderImage:UIImage) {

        if self.image == nil{
              self.image = PlaceHolderImage
        }

        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in

            if error != nil {
                print(error ?? "No Error")
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                self.image = image
            })

        }).resume()
    }}


class ModalViewController: UIViewController, ModalViewControllerProtocol, HalfModalPresentable,
                           UITableViewDelegate, UITableViewDataSource{
    var id: Int = 0
    
    let universities = [
        University(label: "бамонка1", bgImage:"http://edu.bmstu.ru/wp-content/uploads/2018/06/1.jpg"),
        University(label: "бамонка2", bgImage:"http://www.conf2017.rk5.bmstu.ru/images/Foto/mgtu.jpg"),
        University(label: "бамонка3", bgImage:"http://www.conf2017.rk5.bmstu.ru/images/Foto/mgtu.jpg"),
        University(label: "бамонка4", bgImage:"http://www.conf2017.rk5.bmstu.ru/images/Foto/mgtu.jpg")
    ]

    
    var presenter: ModalPresenterProtocol!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    @IBAction func maximazeButtonTapped(sender: AnyObject) {
        print("click maximazed")
        maximizeToFullScreen()
    }
    
    @IBAction func cancelButtonTapped(sender: AnyObject) {
        print("click canceled")
        if let delegate = navigationController?.transitioningDelegate as? HalfModalTransitioningDelegate {
            delegate.interactiveDismiss = false
            print("click canceled 1")
        }
        print("click canceled 2")
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        tableView.delegate = self
        self.tableView.dataSource = self
        
        self.registerTableViewCells()
        
    
        
        print("modal did load")
    }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("segue prepare modal", id)
    }
    
    
     func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return universities.count
    }


    private func registerTableViewCells() {
        let textFieldCell = UINib(nibName: "UnoversityCell",
                                  bundle: nil)
        self.tableView.register(textFieldCell,
                                forCellReuseIdentifier: "UnoversityCell")
    }
    
    private func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
           print("click")
       }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "UnoversityCell") as? UnoversityCell {
            let univer = universities[indexPath.row]
    
            cell.label?.text = univer.label
            
            cell.returnValue = { value in
                       print(self.universities[indexPath.row].label)
                       print(value)
                
                let vc = UniversityModuleConfigurator.configureModule()
                self.navigationController!.show(vc as UIViewController, sender: self)

                   }
            
            
//            let url = URL(string: univer.bgImage)
//            DispatchQueue.global().async {
//                let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
//                DispatchQueue.main.async {
//                    print(url)
//                    cell.backgroundView =  UIImageView(image: UIImage(data: data!))
//                }
//            }
//
        
            return cell
    }
        return UITableViewCell()


}
}



