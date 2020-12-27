//
//  UniversityMapViewController.swift
//  Postuparium
//
//  Created by Сергей Петренко on 13.12.2020.
//

import Foundation
import UIKit

import MapKit


class UniversityMapViewController: SSwipeableViewController,
                                   UniversityMapViewControllerProtocol, MKMapViewDelegate, CLLocationManagerDelegate {
    var idUn: Int = 0
    var menu = HomePageConfigurator.configureModule()
    var umenu = UniversityPageConfigurator.configureModule()
    var smenu = SettingsScreenConfigurator.configureModule()


    let locationManager = CLLocationManager()
    var location: CLLocation!
    
    func zoomMap(byFactor delta: Double) {
        var region: MKCoordinateRegion = self.mapView.region
        var span: MKCoordinateSpan = mapView.region.span
        span.latitudeDelta *= delta
        span.longitudeDelta *= delta
        region.span = span
        if(CLLocationCoordinate2DIsValid(region.center)){
            mapView.setRegion(region, animated: true)
        }
     
        
        
        
    }
    
    
    @IBOutlet weak var zoomPlusBiutton: UIButton!
    @IBAction func zoomPlus(_ sender: Any) {
        zoomMap(byFactor: 0.5)
    
    }
    
    

    @IBOutlet weak var zoomMinusButton: UIButton!
    
    @IBAction func zoomMinus(_ sender: Any) {
        zoomMap(byFactor: 2.0)
    }
    
    @IBOutlet weak var zoomToUserButton: UIButton!
    

    
    @IBAction func zoomToUser(_ sender: Any) {
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.003, longitudeDelta: 0.003)
           let region = MKCoordinateRegion(center: center, span: span)
           self.mapView.setRegion(region, animated: true)
    
    }
    
    
    var halfModalTransitioningDelegate: HalfModalTransitioningDelegate!
    private var universitites = UniversitiesMock.UniversitiesList()
    
    @IBOutlet private var mapView: MKMapView!
    @IBAction func showSettings() {
        showSCard()
    }
    var presenter: UniversityMapPresenterProtocol!
    var configurator: UniversityMapConfiguratorProtocol = UniversityMapConfigurator()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    func initButtons() {
        self.zoomMinusButton.cornerRadius = self.zoomMinusButton.frame.width / 2
        self.zoomPlusBiutton.cornerRadius = self.zoomPlusBiutton.frame.width / 2
        self.zoomToUserButton.cornerRadius = self.zoomToUserButton.frame.width / 2
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.location = locations.last as CLLocation?
    }
    
    final override func viewDidLoad() {
        cardViewController = menu // должно сетиться до вызова родительского метода
        ucardViewController = umenu
        scardViewController = smenu
        super.viewDidLoad()


        self.initButtons()
        
        
        
        
        
        hideKeyboardWhenTappedAround()
        presenter?.viewDidLoad()
        mapView.delegate = self
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        mapView.showsUserLocation = true
        
    
        
    
       
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

        showUCard()
//        self.presenter.showModal(id: Int(id!) ?? 0 )
    }
    
    func mapView(_ mapView: MKMapView,
                   viewFor annotation: MKAnnotation) -> MKAnnotationView? {

        // Leave default annotation for user location
        if annotation is MKUserLocation {
          return nil
        }

        let reuseID = "Location"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseID)
        if annotationView == nil {
          let pin = MKAnnotationView(annotation: annotation,
                                     reuseIdentifier: reuseID)
              pin.image = UIImage(named: "largecircle.fill.circle")
              pin.isEnabled = true
              pin.canShowCallout = false

          let label = UILabel(frame: CGRect(x: 0, y: 0, width: 180, height: 30))
            label.setGradientBackgroundColor(colorOne: .blue, colorTow: .systemBlue)
            label.cornerRadius = 5
            pin.addSubview(label)
            let textLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 180, height: 30))
            textLabel.textColor = .white
            textLabel.cornerRadius = 5
            textLabel.textAlignment = .center
            
            textLabel.text = "Направлений: \(5)"
            pin.addSubview(textLabel)

          annotationView = pin
        } else {
          annotationView?.annotation = annotation
        }

        return annotationView
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




