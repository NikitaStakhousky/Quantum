//
//  InvestDiaryList.swift
//  Quantum
//
//  Created by Nikita Stshovsky on 20.07.2023.
//

import SwiftUI

struct InvestDiaryList: View {
  @EnvironmentObject var viewModel: InvestViewModel
  
  var body: some View {
    ZStack {
      Color.black
        .ignoresSafeArea()
      Image("backgroundImage")
        .resizable()
        .scaledToFill()
        .ignoresSafeArea()
      VStack(spacing: 20) {
        Text("Invest diary")
          .font(.system(size: 40, weight: .bold))
          .foregroundColor(.white)
          .padding(.bottom, 60)
        VStack(spacing: 20) {
          ScrollView {
            ForEach(viewModel.model) { item in
              HStack(spacing: 60) {
                  Text(item.date)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.white)
                    .frame(width: 120, height: 20)
                  Text("\(item.amount) \(item.currency)")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.white)
                    .frame(width: 180, height: 20)
                    
              }
            }
          }.padding()
        }
        addButton()
          .padding(.bottom, 60)
      }
    }
    .sheet(isPresented: $viewModel.showModal) {
      InvestDiaryView()
    }
  }
  
  @ViewBuilder private func addButton() -> some View {
    Button {
      viewModel.showModal.toggle()
    } label: {
      Image("plus")
        .resizable()
        .scaledToFit()
        .frame(width: 80, height: 80)
    }
    
  }
}

struct InvestDiaryList_Previews: PreviewProvider {
  static var previews: some View {
    InvestDiaryList().environmentObject(InvestViewModel())
  }
}
