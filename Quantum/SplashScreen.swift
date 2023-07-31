//
//  SplashScreen.swift
//  Quantum
//
//  Created by Nikita Stshovsky on 20.07.2023.
//

import SwiftUI

struct SplashScreen: View {
  @State private var isActive: Bool = false
  
  var body: some View {
    if isActive {
      MainMenuView()
    } else {
      ZStack {
        Color.black
          .ignoresSafeArea()
        Image("backgroundImage")
          .resizable()
          .ignoresSafeArea()
          .scaledToFill()
        Image("mainImage")
          .resizable()
          .scaledToFit()
          .frame(width: 200, height: 200)
      }
      .onAppear {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
          self.isActive = true
        }
      }
    }
  }
}


struct SplashScreen_Previews: PreviewProvider {
  static var previews: some View {
    SplashScreen()
  }
}
