//
//  HomePageInteractor.swift
//  Postuparium
//
//  Created by Сергей Петренко on 12.10.2020.
//

import Foundation

class HomePageInteractor: HomePageInteractorProtocol {
    
    weak var presenter: HomePagePresenterProtocol!
    
    var universities:[University] = []
    
    func loadUniversities(onFinish: @escaping ([University]) -> Void) {
        UniversitiesService.shared.searchForUniversities(query: "", didFind: { universities in
            self.universities = universities
            onFinish(universities)
        })
    }
}
