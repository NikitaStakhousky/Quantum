//
//  LessonModel.swift
//  Quantum
//
//  Created by Nikita Stshovsky on 08.09.2023.
//

import Foundation
import StoreKit

struct LessonModel: Identifiable {
  var id = UUID()
  var image: String
  var text: String
  var lessontitle: String
  var lessonPreview: String
  var productId: String
  var product: Product
    
    init(id: UUID = UUID(), image: String = "", text: String = "", lessontitle: String = "", lessonPreview: String = "", productId: String = "", product: Product) {
        self.id = id
        self.image = image
        self.text = text
        self.lessontitle = lessontitle
        self.lessonPreview = lessonPreview
        self.productId = productId
        self.product = product
    }
}
