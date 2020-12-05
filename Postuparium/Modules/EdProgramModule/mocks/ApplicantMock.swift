//
//  ApplicantMock.swift
//  Postuparium
//
//  Created by Сергей Петренко on 22.11.2020.
//

import Foundation

struct ApplicantMock: Decodable {
  let name: String
  let category: Category
  
  enum Category: Decodable {
    case all
    case original
  }
  
    func categoryText(category: Category) -> String {
  switch category {
  case Category.all: return "Все"
  case Category.original:return "Оригиналы"
  }
  }
}

extension ApplicantMock.Category: CaseIterable { }

extension ApplicantMock.Category: RawRepresentable {
  typealias RawValue = String
  
  init?(rawValue: RawValue) {
    switch rawValue {
    case "All": self = .all
    case "Original": self = .original
    default: self = .all
    }
  }
  
  var rawValue: RawValue {
    switch self {
    case .all: return "All"
    case .original:return "Original"
    }
  }
  

}

extension ApplicantMock {
  static func applicantsList() -> [ApplicantMock] {
    guard
      let url = Bundle.main.url(forResource: "applicants", withExtension: "json"),
      let data = try? Data(contentsOf: url)
      else {
        return []
    }
    
    do {
      let decoder = JSONDecoder()
      return try decoder.decode([ApplicantMock].self, from: data)
    } catch {
      return []
    }
  }
}
