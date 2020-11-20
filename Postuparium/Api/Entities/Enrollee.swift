//
//  Enrollee.swift
//  Postuparium
//
//  Created by Сергей Петренко on 12.10.2020.
//

import Foundation

struct EgeResults {
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
}

struct PersonalAchievements {
    var goldenMedal: Bool = false
    var gto: Bool = false
    var volunteering: Bool = false
}
struct Enrollee {
    var firstName: String = "Безымянный"
    var lastName: String = "Абитуриент"
    
    var egeResults: EgeResults = EgeResults()
    var achievements: PersonalAchievements = PersonalAchievements()
}
