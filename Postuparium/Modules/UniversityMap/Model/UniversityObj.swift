//
//  University.swift
//  Postuparium
//
//  Created by Сергей Петренко on 20.12.2020.
//

import Foundation
import MapKit
import Contacts

class UniversityObj: NSObject, MKAnnotation {
  let title: String?
  let locationName: String?
  let discipline: String?
  let id: Int
  let coordinate: CLLocationCoordinate2D
  
  init(
    title: String?,
    locationName: String?,
    discipline: String?,
    coordinate: CLLocationCoordinate2D,
    id: Int
  ) {
    self.title = title
    self.locationName = locationName
    self.discipline = discipline
    self.coordinate = coordinate
    self.id = id
    
    super.init()
  }
  
  init?(feature: MKGeoJSONFeature) {
    // 1
    guard
      let point = feature.geometry.first as? MKPointAnnotation,
      // 2
      let propertiesData = feature.properties,
      let json = try? JSONSerialization.jsonObject(with: propertiesData),
      let properties = json as? [String: Any]
      else {
        return nil
    }
    
    // 3
    title = properties["title"] as? String
    locationName = properties["location"] as? String
    discipline = properties["discipline"] as? String
    id = properties["id"] as! Int
    coordinate = point.coordinate
    super.init()
  }
  
  var subtitle: String? {
    let res = "\(String(describing: id))"
    return res
  }
  
  var mapItem: MKMapItem? {
    guard let location = locationName else {
      return nil
    }
    
    let addressDict = [CNPostalAddressStreetKey: location]
    let placemark = MKPlacemark(
      coordinate: coordinate,
      addressDictionary: addressDict)
    let mapItem = MKMapItem(placemark: placemark)
    mapItem.name = title
    return mapItem
  }
  
  var markerTintColor: UIColor  {
    switch discipline {
    case "Monument":
      return .red
    case "Mural":
      return .cyan
    case "Plaque":
      return .blue
    case "Sculpture":
      return .purple
    default:
      return .green
    }
  }
  
  var image: UIImage {
    guard let name = discipline else { return #imageLiteral(resourceName: "icon@2x.png") }
    return UIImage.init(systemName: "circle" )!
    switch name {
    case "Monument":
      return #imageLiteral(resourceName: "icon@2x.png")
    case "Sculpture":
      return #imageLiteral(resourceName: "Logo@2x.png")
    case "Plaque":
      return #imageLiteral(resourceName: "Logo@2x.png")
    case "Mural":
      return #imageLiteral(resourceName: "icon@2x.png")
    default:
      return #imageLiteral(resourceName: "icon@2x.png")
    }
  }
}
