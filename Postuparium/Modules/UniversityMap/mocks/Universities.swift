//
//  Universities.swift
//  Postuparium
//
//  Created by Сергей Петренко on 22.12.2020.
//

import Foundation

struct UniversitiesMock: Decodable {
    let name: String
    let about: String
    let preview: String
    let id: Int
    let lat: String
    let lon: String
}


extension UniversitiesMock {
  static func UniversitiesList() -> [UniversitiesMock] {
    guard
      let url = Bundle.main.url(forResource: "universities", withExtension: "json"),
      let data = try? Data(contentsOf: url)
      else {

        return []
    }
    
    do {
      let decoder = JSONDecoder()
        print(data)
        return try decoder.decode([UniversitiesMock].self, from: data)
    } catch {

      return []
    }
  }
}
