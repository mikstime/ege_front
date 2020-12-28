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
    var place: Int = 0 //qs
    var rating: Double = 0.0
    var name: String = ""
    var image: String = "" // preview
    var description: String = ""
    var id: Int = 0
    var site: String = ""
    var ed_programs: [EdProgram] = []
    var photos: [Photo] = []
    var lat: Double = 0.0
    var lon: Double = 0.0
 }
