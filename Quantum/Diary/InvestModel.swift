//
//  InvestModel.swift
//  Quantum
//
//  Created by Nikita Stshovsky on 21.07.2023.
//

import Foundation

struct InvestModel: Identifiable, Codable {
  var id = UUID()
  let date: String
  let amount: Int
  let currency: String
}
