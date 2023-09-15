//
//  LessonStructMapper.swift
//  Quantum
//
//  Created by Nikita Stshovsky on 08.09.2023.
//

import Foundation
import StoreKit

class StructMapper {
 static let shared = StructMapper()
  
    func mapper(productModel: [Product], lessonModel: [Lesson]) -> [LessonModel] {
    var model: [LessonModel] = []
        for index in 0...5 {
           let lesson = lessonModel[index] 
            let product = productModel[index]
                model.append(LessonModel(image: lesson.img, text: lesson.text, lessontitle: lesson.lessontitle, lessonPreview: lesson.lessonPreview, productId: lesson.productId, product: product))
        }
    return model
  }
}
