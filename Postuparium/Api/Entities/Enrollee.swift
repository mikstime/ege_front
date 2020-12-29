//
//  Enrollee.swift
//  Postuparium
//
//  Created by Сергей Петренко on 12.10.2020.
//

import Foundation

struct EgeResults: Codable {
    var total: Int = 0
    var russian: Int = 0
    var mathProf: Int = 0
    var mathBase: Int = 0
    var biology: Int = 0
    var informatics: Int = 0
    var socialStudies: Int = 0
    var physics: Int = 0
    var chemistry: Int = 0
    var history: Int = 0
    var geography: Int = 0
    var english: Int = 0
    var german: Int = 0
    var french: Int = 0
    var chinese: Int = 0
    var spanish: Int = 0
    var literature: Int = 0
    
    var dictionary: [String: Any] {
            return [
                "total":         total,
                "russian":       russian,
                "mathProf":      mathProf,
                "mathBase":      mathBase,
                "biology":       biology,
                "informatics":   informatics,
                "socialStudies": socialStudies,
                "physics":       physics,
                "chemistry":     chemistry,
                "history":       history,
                "geography":     geography,
                "english":       english,
                "german":        german,
                "french":        french,
                "chinese":       chinese,
                "spanish":       spanish,
                "literature":    literature,
            ]
    }
}

struct PersonalAchievements: Codable {
    var goldenMedal: Bool = false
    var gto: Bool = false
    var volunteering: Bool = false
    
    var dictionary: [String: Any] {
            return ["goldenMedal": goldenMedal,
                    "gto": gto,
                    "volunteering": volunteering,
            ]
    }
    
}

struct Enrollee: Codable {
    var id: Int = 0
    var firstName: String = "Безымянный"
    var lastName: String = "Абитуриент"
    var token: String = ""
    var email: String? = ""
    var password: String? = "rabndom string1"
    var egeResults: EgeResults = EgeResults()
    var achievements: PersonalAchievements = PersonalAchievements()
    
    var chosenPrograms: [EdProgram] = []
    
    var key = "enrollee"
    
    var dictionary: [String: Any] {
            return ["first_name": firstName,
                    "last_name": lastName,
                    "token": token,
                    "password": "rabndom string1",
                    "ege_results": egeResults.dictionary,
                    "achievements": achievements.dictionary,
            ]
    }
    
    var dictionaryLogin: [String: Any] {
            return ["token": token]
    }
    
    private enum CodingKeys: String, CodingKey {
            case id, token, email, password, achievements
            case firstName = "first_name"
            case lastName = "last_name"
            case egeResults = "ege_results"
    }
    
    init(default: Bool) {}
    
    init() {
        self = GlobalSettings.enrollee
    }
    
    func save() {
        GlobalSettings.enrollee = self
    }
}
