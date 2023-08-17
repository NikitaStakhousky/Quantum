//
//  CurrencyViewModel.swift
//  Quantum
//
//  Created by Nikita Stshovsky on 15.08.2023.
//

import Foundation

final class CurrencyViewModel: ObservableObject {
  @Published var model: [Currency] = []
  private let networkService = NetworkService()
  
  func getCurrencies() {
    networkService.getCurrencies { currency in
      DispatchQueue.main.async {
        self.model = currency
      }
    }
  }
}
