//
//  PurchaseView.swift
//  Quantum
//
//  Created by Nikita Stshovsky on 07.09.2023.
//

import SwiftUI

struct PurchaseView: View {
    @EnvironmentObject private var purchaseManager: LessonViewModel
    var body: some View {
        VStack(spacing: 18) {
            ForEach(purchaseManager.products) { product in
                if purchaseManager.hasUnlockedPro {
                    EmptyView()
                } else {
                    PurchaseButton(displayPrice: product.displayPrice, product: product)
                }
            }
        }.frame(width: 54)
        .task {
            do {
                try await purchaseManager.loadProducts()
            } catch {
                print(error)
            }
        }
    }
}

struct PurchaseView_Previews: PreviewProvider {
    static var previews: some View {
        PurchaseView().environmentObject(LessonViewModel())
    }
}
