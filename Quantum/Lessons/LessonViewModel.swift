//
//  LessonViewModel.swift
//  Quantum
//
//  Created by Nikita Stshovsky on 26.07.2023.
//

import Foundation

final class LessonViewModel: ObservableObject {
  @Published var model: [Lesson] = []
  
  private let networkService = NetworkService()
  
  func getData() {
    networkService.getData { lesson in
      DispatchQueue.main.async {
        self.model = lesson
      }
    }
  }
}
