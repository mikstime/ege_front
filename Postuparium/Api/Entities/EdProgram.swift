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
    var universityId: Int = 0
    var photo: String = ""
    var probability: String = ""
    var probablilityNumber: Double = 0.0 // 0 - 1
    var id: Int = 0
    
    private enum CodingKeys: String, CodingKey {
            case id, code, name, university, photo, probability
            case universityId = "university_id"
        case probablilityNumber = "probability_number"
    }
}
