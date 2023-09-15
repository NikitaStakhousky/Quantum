//
//  PurchaseButton.swift
//  Quantum
//
//  Created by Nikita Stshovsky on 07.09.2023.
//

import SwiftUI
import StoreKit

struct PurchaseButton: View {
    let displayPrice: String
    let purchaseManager = LessonViewModel()
    let product: Product
    
    var body: some View {
            VStack{
                Button(action: {
                    Task {
                        do {
                            try await purchaseManager.purchase(product)
                        } catch {
                            print(error)
                        }
                    }
                }){
                    Text(displayPrice)
                        .frame(width: 54, height: 54)
                        .foregroundColor(Color.white)
                        .background(Color.black)
                        .clipShape(Circle())
                        .shadow(color: .white, radius: 3)
                }.buttonStyle(PlainButtonStyle())
            }.frame(width: 30, height: 50)
    }
}
