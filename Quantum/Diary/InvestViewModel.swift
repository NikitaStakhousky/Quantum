//
//  InvestViewModel.swift
//  Quantum
//
//  Created by Nikita Stshovsky on 21.07.2023.
//

import Foundation
import SwiftUI

final class InvestViewModel: ObservableObject {
  @Published var model: [InvestModel] = []
  @Published var showModal: Bool = false
  var amountArray = (UserDefaults.standard.array(forKey: "amountArray") as? [Double]) ?? [1,2,3,4]
  
//  func addNewValue(date: Date, amount: Int, currency: String) {
//    let dateFormatter = DateFormatter()
//    dateFormatter.dateFormat = "dd.MM.YYYY"
//    amountArray.append(Double(amount))
//    UserDefaults.standard.set(amountArray, forKey: "amountArray")
//    print(amountArray)
//    model.append(InvestModel(date: dateFormatter.string(from: date), amount: amount, currency: currency))
//  }
  
  func add(date: Date, amount: Int, currency: String) {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd.MM.YYYY"
    amountArray.append(Double(amount))
    model.append(InvestModel(date: dateFormatter.string(from: date), amount: amount, currency: currency))
    save()
  }
  
  func save() {
      if let encoded = try? JSONEncoder().encode(model) {
          UserDefaults.standard.set(encoded, forKey: "SavedData")
      }
    UserDefaults.standard.set(amountArray, forKey: "amountArray")
  }
  
  init() {
    if let data = UserDefaults.standard.data(forKey: "SavedData") {
      if let decoded = try? JSONDecoder().decode([InvestModel].self, from: data) {
        self.model = decoded
        return
      }
    }
  }
}
