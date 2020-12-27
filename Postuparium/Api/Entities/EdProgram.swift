//
//  EdProgram.swift
//  Postuparium
//
//  Created by Сергей Петренко on 12.10.2020.
//

import Foundation

struct EdProgram: Codable {
    var code: String = ""
    var name: String = ""
    var university: String = ""
    var photo: String = ""
    var probability: String = ""
    var probablilityNumber: Double = 0.0 // 0 - 1
    var id: Int = 0
    var preview: String
}
