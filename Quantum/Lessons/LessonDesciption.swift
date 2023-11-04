//
//  LessonDesciption.swift
//  Quantum
//
//  Created by Nikita Stshovsky on 20.07.2023.
//

import SwiftUI

struct LessonDesciption: View {
  var lessonText: String
  var lessonImg: String
  var lessonTitle: String
  
  var body: some View {
    ZStack {
      Color.black
        .ignoresSafeArea()
      Image("backgroundImage")
        .resizable()
        .scaledToFill()
        .ignoresSafeArea()
      VStack {
        ScrollView(showsIndicators: false) {
          Text(lessonTitle)
            .font(.system(size: 34, weight: .bold))
            .frame(width: 280, height: 54)
            .foregroundColor(.white)
            .cornerRadius(12)
            .overlay(
              RoundedRectangle(cornerRadius: 28)
                .stroke(Color.white, lineWidth: 2)
                .shadow(color: .white, radius: 6)
            )
          AsyncImage(url: URL(string: lessonImg)) { image in
            image
              .resizable()
              .scaledToFit()
              .frame(width: 340, height: 340)
              .shadow(color: .white, radius: 6)
          } placeholder: {
            ProgressView()
              .background(Color.black)
              .frame(width: 340, height: 340)
          }
          Text(lessonText)
            .foregroundColor(.white)
            .font(.system(size: 24, weight: .bold))
            .frame(width: 340)
            .padding()
        }
      }
    }
  }
}
