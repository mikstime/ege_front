//
//  AchievementsSelectionInteractor.swift
//  Postuparium
//
//  Created by Сергей Петренко on 12.10.2020.
//

import Foundation

class AchievementsSelectionInteractor: AchievementsSelectionInteractorProtocol {
    
    weak var presenter: AchievementsSelectionPresenterProtocol!
    
    var enrollee: Enrollee = Enrollee()
    
    func updateGoldenMedal(state: Bool) {
        enrollee.achievements.goldenMedal = state
        EnrolleeService
            .shared
            .setPersonalAchievements(achievements: enrollee.achievements)
    }
    
    func updateGto(state: Bool) {
        enrollee.achievements.gto = state
        EnrolleeService
            .shared
            .setPersonalAchievements(achievements: enrollee.achievements)
    }
    
    func updateVolunteering(state: Bool) {
        enrollee.achievements.volunteering = state
        EnrolleeService
            .shared
            .setPersonalAchievements(achievements: enrollee.achievements)
    }
    func getEnrollee() -> Enrollee {
        return enrollee
    }
}
