//
//  SettingsView.swift
//  Quantum
//
//  Created by Nikita Stshovsky on 21.07.2023.
//

import SwiftUI

struct SettingsView: View {
  var selectedSize: [CGFloat] = [20, 24, 32, 30, 40]
  @State private var currentSize: CGFloat = 0.0
  @State private var pushOffOn: Bool = false
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
          Text("Settings")
            .foregroundColor(.white)
            .font(.system(size: 40, weight: .bold))
              Toggle("Notifications", isOn: $pushOffOn)
                .font(.system(size: 34, weight: .bold))
                .foregroundColor(.white)
                .toggleStyle(SwitchToggleStyle(tint: .gray))
                .padding()
                .frame(width: 300)
        }
      }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
