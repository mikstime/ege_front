//
//  University.swift
//  Postuparium
//
//  Created by Сергей Петренко on 12.10.2020.
//

import Foundation

import UIKit

struct University:Codable {
    var scores: Int = 0
    var numberOfPrograms: Int = 0 // programs_counter
    var place: String = "" //qs
    var rating: Double = 0.0
    var name: String = ""
    var image: String = "" // preview
    var description: String = ""
    var id: Int = 0
    var site: String = ""
    var photos: [Photo] = []
    var lat: Double = 0.0
    var lon: Double = 0.0
    
    private enum CodingKeys: String, CodingKey {
        case scores, rating, name, id, site, photos, lat, lon
        case place = "qs"
        case numberOfPrograms = "programs_counter"
        case image = "preview"
        case description = "about"
    }
 }

