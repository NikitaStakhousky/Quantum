//
//  VisualView.swift
//  Quantum
//
//  Created by Nikita Stshovsky on 21.07.2023.
//

import SwiftUI
import SwiftUICharts

struct VisualView: View {
  @StateObject var viewModel: InvestViewModel
  @Environment(\.colorScheme) var colorScheme
  let data = (UserDefaults.standard.array(forKey: "amountArray") as? [Double]) ?? [10, 20]
  
  var body: some View {
    ZStack {
      Color.black
        .ignoresSafeArea()
      Image("backgroundImage")
        .resizable()
        .scaledToFill()
        .ignoresSafeArea()
      VStack {
        Text("Your investitions")
          .foregroundColor(.white)
          .font(.system(size: 40, weight: .bold))
        LineView(data: data, title: "Visual", style: Styles.barChartStyleNeonBlueDark)
          .padding()
      }.frame(width: 400)
        .padding()
    }
  }
}

struct VisualView_Previews: PreviewProvider {
  static var previews: some View {
    VisualView(viewModel: InvestViewModel())
  }
}
