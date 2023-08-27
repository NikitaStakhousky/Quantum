//
//  LessonsView.swift
//  Quantum
//
//  Created by Nikita Stshovsky on 20.07.2023.
//

import SwiftUI
import PopupView

struct LessonsView: View {
  @StateObject var viewModel: LessonViewModel
  @State var showPopup = false
  @State var image: String = ""
  @State var title: String = ""
  
  var body: some View {
    ZStack {
      Color.black
        .ignoresSafeArea()
      Image("backgroundImage")
        .resizable()
        .scaledToFill()
        .ignoresSafeArea()
      VStack {
        HStack {
          Image("mainImage")
            .resizable()
            .scaledToFit()
            .frame(width: 80, height: 80)
          Spacer()
        }.frame(width: 300)
        Spacer()
      }
      VStack {
        Text("Lessons")
          .foregroundColor(.white)
          .font(.system(size: 40, weight: .bold))
          .padding(.bottom, 40)
        VStack(spacing: 14) {
          ForEach(viewModel.model) { item in
            if item.lessontitle == "For beginner" {
              NavigationLink {
                LessonDesciption(lessonText: item.text, lessonImg: item.img, lessonTitle: item.lessontitle)
              } label: {
                Text(item.lessontitle)
                  .font(.system(size: 34, weight: .bold))
                  .frame(width: 280, height: 54)
                  .foregroundColor(.white)
                  .cornerRadius(12)
                  .overlay(
                    RoundedRectangle(cornerRadius: 28)
                      .stroke(Color.white, lineWidth: 2)
                      .shadow(color: .white, radius: 6)
                  )
              }
            } else {
              Button {
                showPopup = true
                image = item.img
                title = item.lessontitle
              } label: {
                Text(item.lessontitle)
                  .font(.system(size: 34, weight: .bold))
                  .frame(width: 280, height: 54)
                  .foregroundColor(.white)
                  .cornerRadius(12)
                  .overlay(
                    RoundedRectangle(cornerRadius: 28)
                      .stroke(Color.white, lineWidth: 2)
                      .shadow(color: .white, radius: 6)
                  )
              }
            }
          }
        }
      }
    }
    .popup(isPresented: $showPopup) {
      PopupView(img: image, title: title)
    } customize: {
      $0
        .type(.floater())
        .position(.bottom)
        .animation(.spring())
        .closeOnTapOutside(true)
        .backgroundColor(.black.opacity(0.7))
    }
    .onAppear {
      viewModel.getData()
    }
  }
}

struct LessonsView_Previews: PreviewProvider {
  static var previews: some View {
    LessonsView(viewModel: LessonViewModel())
  }
}
