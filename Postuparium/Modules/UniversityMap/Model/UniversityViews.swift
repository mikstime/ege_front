//
//  UniversityViews.swift
//  Postuparium
//
//  Created by Сергей Петренко on 20.12.2020.
//

import Foundation
import MapKit

class UniversityMarkerView: MKMarkerAnnotationView {
  override var annotation: MKAnnotation? {
    willSet {
      // 1
      guard let university = newValue as? UniversitiesMock else {
        return
      }
      canShowCallout = true
      calloutOffset = CGPoint(x: -5, y: 5)
      rightCalloutAccessoryView = UIButton(type: .detailDisclosure)

      // 2
      backgroundColor = UIColor.blue
      markerTintColor = .blue
      glyphImage = UIImage.init(systemName: "studentdesk" )!
    }
  }

}

class UniversityView: MKAnnotationView {
  override var annotation: MKAnnotation? {
    willSet {
      guard let university = newValue as? UniversitiesMock else {
        return
      }

      canShowCallout = true
      calloutOffset = CGPoint(x: -5, y: 5)
    
//        image = university.preview
      
      let detailLabel = UILabel()
      detailLabel.numberOfLines = 0
      detailLabel.font = detailLabel.font.withSize(12)
        detailLabel.text = university.name
      detailCalloutAccessoryView = detailLabel
     

        
    }
  }
}
