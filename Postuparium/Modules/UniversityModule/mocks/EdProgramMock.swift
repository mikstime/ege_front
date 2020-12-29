//
//  EdProgramMock.swift
//  Postuparium
//
//  Created by Сергей Петренко on 21.11.2020.
//

import Foundation

struct EdProgramMock: Decodable {
    let code: String
    let name: String
    let codeName: String
    let edProgram: String
    let id: Int
    let photo: String

    

}


extension EdProgramMock {
  static func edProgramsList() -> [EdProgramMock] {
    guard
      let url = Bundle.main.url(forResource: "edPrograms", withExtension: "json"),
      let data = try? Data(contentsOf: url)
      else {
        return []
    }
    
    do {
      let decoder = JSONDecoder()
      return try decoder.decode([EdProgramMock].self, from: data)
    } catch {
      return []
    }
  }
}
