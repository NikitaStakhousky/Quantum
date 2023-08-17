//
//  EventViewModel.swift
//  Quantum
//
//  Created by Nikita Stshovsky on 15.08.2023.
//

import Foundation

final class EventViewModel: ObservableObject {
  @Published var model: Event?
  private var networkService = NetworkService()
  @Published var showAlert = false
  func getEvent() {
    networkService.getEvent { item in
      DispatchQueue.main.async {
        self.model = item
      }
    }
  }
}
