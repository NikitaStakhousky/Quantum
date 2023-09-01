//
//  PopupView.swift
//  Quantum
//
//  Created by Nikita Stshovsky on 26.08.2023.
//

import SwiftUI
import StoreKit

struct PopupView: View {
    var img: String
    var title: String
    var lessonPreview: String
    @EnvironmentObject
    private var purchaseManager: PurchaseManager
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.7)
            VStack {
                Text(title)
                    .font(.system(size: 34, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.top, -10)
                AsyncImage(url: URL(string: img)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 340, height: 280)
                        .shadow(color: .white, radius: 6)
                } placeholder: {
                    ProgressView()
                        .background(Color.black)
                        .frame(width: 340, height: 340)
                }
                .padding(.top, 40)
                VStack(spacing: 30) {
                    Text(lessonPreview)
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                    Text("Our lesson by Quantum Team learn you \ntrade on the stock market.")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                }
                .padding(.top, 20)
                Button {
                    Task {
                        do {
                            try await purchaseManager.purchase(purchaseManager.products.first!)
                        } catch {
                            print(error)
                        }
                    }
                } label: {
                    Text("Buy")
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
                .padding(.top, 40)
            }.padding()
        }.frame(width: 360, height: 750)
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.white, lineWidth: 2)
                    .shadow(color: .white, radius: 6)
            )
            .task {
                Task {
                    do {
                        try await purchaseManager.loadProducts()
                    } catch {
                        print(error)
                    }
                }
             }
          }
       }

struct PopupView_Previews: PreviewProvider {
    static var previews: some View {
        PopupView(img: "https://images.unsplash.com/photo-1692854236272-cc49076a2629?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=3270&q=80", title: "lesson 1", lessonPreview: "How to trade market?")
    }
}
