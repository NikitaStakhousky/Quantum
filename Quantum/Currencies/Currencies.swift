//
//  Currencies.swift
//  Quantum
//
//  Created by Nikita Stshovsky on 15.08.2023.
//

import SwiftUI

struct Currencies: View {
 @StateObject var viewModel: CurrencyViewModel

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
            Text("Currencies")
              .foregroundColor(.white)
              .font(.system(size: 40, weight: .bold))
            ForEach(viewModel.model) { item in
              CurrenciesCell(currency: item.currency, descriptionCurrency: item.descriptionCurrency, price: item.price, profit: item.profit)
            }.padding(.all, 6)
          }.padding()
        }
      }
      .onAppear {
        viewModel.getCurrencies()
      }
    }
}

struct Currencies_Previews: PreviewProvider {
    static var previews: some View {
      Currencies(viewModel: CurrencyViewModel())
    }
}
