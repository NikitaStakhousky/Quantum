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
struct Currency: Codable, Identifiable {
  var id = UUID()
  let currency: String
  let price: String
  let descriptionCurrency: String
  let profit: String
  
  enum CodingKeys: String, CodingKey {
    case currency = "currency"
    case price = "price"
    case descriptionCurrency = "descriptionCurrency"
    case profit = "profit"
  }
}

struct Event: Codable {
  let img: String
  let text: String
  
  enum CodingKeys: String, CodingKey {
    case img = "img"
    case text = "text"
  }
}
