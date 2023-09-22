//
//  LessonsView.swift
//  Quantum
//
//  Created by Nikita Stshovsky on 20.07.2023.
//

import SwiftUI
import PopupView
import StoreKit

struct LessonsView: View {
    @StateObject var viewModel: LessonViewModel
    @State private var showPopup = false
    @State private var model: [LessonModel] = []
    @State private var image: String = ""
    @State private var title: String = ""
    @State private var preview: String = ""
    @State private var product: Product?
    
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
              NavigationLink {
                FirstLessonView()
              } label: {
                Text("Lesson 1")
                    .font(.system(size: 34, weight: .bold))
                    .frame(width: 280, height: 54)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 28)
                            .stroke(Color.white, lineWidth: 2)
                            .shadow(color: .white, radius: 6)
                    )
              }.padding(.bottom, 10)
                    VStack(spacing: 14) {
                        ForEach(model) { item in
                            if viewModel.purchasedProductIDs.contains(item.product.id) {
                                NavigationLink {
                                    LessonDesciption(lessonText: item.text, lessonImg: item.image, lessonTitle: item.lessontitle)
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
                                    image = item.image
                                    title = item.lessontitle
                                    product = item.product
                                    preview = item.lessonPreview
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
                Button {
                    Task {
                        do {
                            try await AppStore.sync()
                        } catch {
                            print(error)
                        }
                    }
                } label: {
                    Text("Restore Purchases")
                    .foregroundColor(.white)

                }
            }
            }
            .popup(isPresented: $showPopup) {
                PopupView(img: image, title: title, lessonPreview: preview, product: product).environmentObject(LessonViewModel())
            } customize: {
                $0
                    .type(.floater())
                    .position(.bottom)
                    .animation(.spring())
                    .closeOnTapOutside(true)
                    .backgroundColor(.black.opacity(0.7))
            }
            .task {
                do {
                    try await viewModel.loadProducts()
                } catch {
                    print(error)
                }
                model = StructMapper.shared.mapper(productModel: viewModel.products, lessonModel: viewModel.model)
               
                await viewModel.updatePurchasedProducts()
                                    
            }
        }
    }

struct LessonsView_Previews: PreviewProvider {
  static var previews: some View {
    LessonsView(viewModel: LessonViewModel())
  }
}
