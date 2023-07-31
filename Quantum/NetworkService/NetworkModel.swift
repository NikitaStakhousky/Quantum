//
//  NetworkModel.swift
//  Quantum
//
//  Created by Nikita Stshovsky on 26.07.2023.
//

import Foundation

struct Lesson: Codable, Identifiable {
  var id = UUID()
  let img: String
  let text: String
  let lessontitle: String
  
  enum CodingKeys: String, CodingKey {
    case img = "img"
    case text = "text"
    case lessontitle = "lessontitle"
  }
}
