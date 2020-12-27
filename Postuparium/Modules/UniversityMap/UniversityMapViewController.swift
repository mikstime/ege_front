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
    
    private var universitites = UniversitiesMock.UniversitiesList()
    
    @IBOutlet private var mapView: MKMapView!
    
    
    var presenter: UniversityMapPresenterProtocol!
    var configurator: UniversityMapConfiguratorProtocol = UniversityMapConfigurator()

    final override func viewDidLoad() {
        super.viewDidLoad()

        presenter?.viewDidLoad()
    
        
        mapView.delegate = self
        
        // Закомменчено на время рефакторинга меток на карте
//        mapView.register(
//          UniversityView.self,
//          forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
//        
//        loadInitialData()
       
        var annotations: [MKPointAnnotation] = []
        
        for univer in universitites {
            print("univer " ,univer)
            let annotation = MKPointAnnotation()
            annotation.coordinate.latitude = (univer.lat as NSString).doubleValue
            annotation.coordinate.longitude = (univer.lon as NSString).doubleValue
            annotation.title = univer.name
            annotation.subtitle = "\(univer.id)"
    
            annotations.append(annotation)
        }
        print(annotations)
        mapView.addAnnotations(annotations)
    
       
        
    
    }
    

    func setMapFocus(centerCoordinate: CLLocationCoordinate2D, radiusInKm radius: CLLocationDistance)
    {
    let diameter = radius * 2000
        let region: MKCoordinateRegion = MKCoordinateRegion(center: centerCoordinate, latitudinalMeters: diameter, longitudinalMeters: diameter)
    self.mapView.setRegion(region, animated: false)
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let id = view.annotation!.subtitle!
        mapView.setCenter(view.annotation!.coordinate, animated: true)
        setMapFocus(centerCoordinate: view.annotation!.coordinate, radiusInKm: 0.5)
        print("Ебать нажалось", id! , Int(id!) ?? 0 )
        self.presenter.showModal(id: Int(id!) ?? 0 )
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        presenter.router.prepare(for: segue, sender: sender)
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
    guard let univer = view.annotation as? UniversityObj else {
      return
    }

    let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
    univer.mapItem?.openInMaps(launchOptions: launchOptions)

  }
}




