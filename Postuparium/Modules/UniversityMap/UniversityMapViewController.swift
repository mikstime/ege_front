//
//  UniversityMapViewController.swift
//  Postuparium
//
//  Created by Сергей Петренко on 13.12.2020.
//

import Foundation
import UIKit

import MapKit

class UniversityMapViewController: UIViewController,
                                   UniversityMapViewControllerProtocol, MKMapViewDelegate {
    var idUn: Int = 0
    
    var halfModalTransitioningDelegate: HalfModalTransitioningDelegate!
    
    private var universitites: [UniversityObj] = []
    
    @IBOutlet private var mapView: MKMapView!
    
    
    var presenter: UniversityMapPresenterProtocol!
    var configurator: UniversityMapConfiguratorProtocol = UniversityMapConfigurator()

    final override func viewDidLoad() {
        super.viewDidLoad()

        presenter?.viewDidLoad()
    
        
        mapView.delegate = self
        
        mapView.register(
          UniversityView.self,
          forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        
        loadInitialData()
        print(universitites)
        mapView.addAnnotations(universitites)
        
    
    }
    
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let id = view.annotation!.subtitle!
        print("Ебать нажалось", id! , Int(id!) ?? 0 )
        self.presenter.showModal(id: Int(id!) ?? 0 )
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        presenter.router.prepare(for: segue, sender: sender)
    }
    
    
    private func loadInitialData() {
        
      // 1
      guard
        let fileName = Bundle.main.url(forResource: "testData", withExtension: "geojson"),
        let artworkData = try? Data(contentsOf: fileName)
        else {
        print("empty")
          return
      }
      
      do {
        // 2
        let features = try MKGeoJSONDecoder()
          .decode(artworkData)
          .compactMap { $0 as? MKGeoJSONFeature }
        print("decode features")
        // 3
        let validWorks = features.compactMap(UniversityObj.init)
        // 4
        print("return empty2")
        universitites.append(contentsOf: validWorks)
      } catch {
        // 5
        print("Unexpected error: \(error).")
      }
    }
    
    
   
}



private extension MKMapView {
  func centerToLocation(_ location: CLLocation, regionRadius: CLLocationDistance = 1000) {
    let coordinateRegion = MKCoordinateRegion(
      center: location.coordinate,
      latitudinalMeters: regionRadius,
      longitudinalMeters: regionRadius)
    setRegion(coordinateRegion, animated: true)
  }
}

extension ViewController: MKMapViewDelegate {
  func mapView(
    _ mapView: MKMapView,
    annotationView view: MKAnnotationView,
    calloutAccessoryControlTapped control: UIControl
  ) {
    guard let artwork = view.annotation as? UniversityObj else {
      return
    }
    
    let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
    artwork.mapItem?.openInMaps(launchOptions: launchOptions)
    print("ogo ebat")
  }
}




