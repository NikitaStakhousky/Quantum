//
//  CurrenciesCell.swift
//  Quantum
//
//  Created by Nikita Stshovsky on 15.08.2023.
//

import SwiftUI

struct CurrenciesCell: View {
  var currency: String
  var descriptionCurrency: String
  var price: String
  var profit: String
  
  var body: some View {
    ZStack {
      Color.black
        .ignoresSafeArea()
      HStack {
        VStack(alignment: .leading) {
          Text(currency)
            .font(.system(size: 28, weight: .bold))
            .foregroundColor(.white)
          Text(descriptionCurrency)
            .foregroundColor(.white)
        }
        Spacer()
        VStack {
          Text(price)
            .font(.system(size: 22, weight: .bold))
            .foregroundColor(.white)
          Text(profit)
            .foregroundColor(.white)
        }
      }.padding()
    } .frame(width: 360, height: 50)
      .cornerRadius(6)
      .shadow(color: .white, radius: 4)
  }
}
