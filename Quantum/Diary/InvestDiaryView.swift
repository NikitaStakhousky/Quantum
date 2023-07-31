//
//  InvestDiaryView.swift
//  Quantum
//
//  Created by Nikita Stshovsky on 20.07.2023.
//

import SwiftUI

struct InvestDiaryView: View {
  var currency = ["USD", "BTC", "ETH", "XLM", "DASH", "XMR", "LTC", "DOT", "SOL"]
  @State private var selectedCurrency = "USD"
  @State private var currentDate = Date.now
  @State private var newAmount = ""
  @EnvironmentObject var viewModel: InvestViewModel
  
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
          Spacer()
          Image("mainImage")
            .resizable()
            .scaledToFit()
            .frame(width: 80, height: 80)
        }.frame(width: 300)
        Spacer()
      }
      VStack {
        Text("Invest diary")
          .font(.system(size: 40, weight: .bold))
          .foregroundColor(.white)
        VStack {
          Text("Date")
            .foregroundColor(.black)
            .font(.system(size: 24, weight: .bold))
            .padding(.bottom, -10)
          DatePicker("Select date", selection: $currentDate, displayedComponents: .date)
            .padding()
          Rectangle()
            .fill(Color.black)
            .frame(width: 260, height: 4)
          Text("Currency")
            .foregroundColor(.black)
            .font(.system(size: 24, weight: .bold))
            .padding(.bottom, -10)
          Picker("Please choose a color", selection: $selectedCurrency) {
            ForEach(currency, id: \.self) {
              Text($0)
                .foregroundColor(.black)
            }
          }.pickerStyle(.menu)
            .colorMultiply(.black).colorInvert()
            .colorMultiply(.white).colorInvert()
          Rectangle()
            .fill(Color.black)
            .frame(width: 260, height: 4)
          Text("Amount")
            .foregroundColor(.black)
            .font(.system(size: 24, weight: .bold))
          TextField("", text: $newAmount)
            .frame(height: 34)
            .foregroundColor(.black)
            .overlay(
              RoundedRectangle(cornerRadius: 6)
                .stroke(Color.black, lineWidth: 1)
            )
            .multilineTextAlignment(.center)
            .frame(width: 240)
          Rectangle()
            .fill(Color.black)
            .frame(width: 260, height: 4)
        }.frame(width: 340, height: 400)
          .background(Color.white)
          .cornerRadius(20)
        doneButton()
      }
    }
  }
  @ViewBuilder private func doneButton() -> some View {
    Button {
      viewModel.showModal.toggle()
      viewModel.add(date: currentDate, amount: (Int(newAmount) ?? 0), currency: selectedCurrency)
    } label: {
      Image("done")
        .resizable()
        .scaledToFit()
        .frame(width: 80, height: 80)
    }
    }
  }



struct InvestDiaryView_Previews: PreviewProvider {
  static var previews: some View {
    InvestDiaryView().environmentObject(InvestViewModel())
  }
}
