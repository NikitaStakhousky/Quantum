//
//  MainMenuView.swift
//  Quantum
//
//  Created by Nikita Stshovsky on 20.07.2023.
//

import SwiftUI

struct MainMenuView: View {
  
  @State private var showCalculator: Bool = false
  
  var body: some View {
    NavigationView {
      ZStack {
        Color.black
          .ignoresSafeArea()
        Image("backgroundImage")
          .resizable()
          .scaledToFill()
          .ignoresSafeArea()
        VStack(alignment: .center) {
          Spacer()
            menuButtons()
              .padding(.bottom, 70)
          NavigationLink {
            FinCalculatorView()
              .preferredColorScheme(.dark)
          } label: {
            Text("calculate procent")
              .font(.system(size: 26, weight: .bold))
              .frame(width: 280, height: 54)
              .foregroundColor(.white)
              .cornerRadius(12)
              .overlay(
                RoundedRectangle(cornerRadius: 28)
                  .stroke(Color.white, lineWidth: 2)
                  .shadow(color: .white, radius: 6)
              )
          }
        }
      }
      .toolbar {
        HStack {
          Image("quantumAI")
          .resizable()
          .scaledToFit()
          .frame(width: 160, height: 160)
          Spacer()
        }
      }
    }
  }
}

@ViewBuilder private func menuButtons() -> some View {
  VStack {
    HStack(spacing: 100) {
      NavigationLink {
        InvestDiaryList().environmentObject(InvestViewModel())
      } label: {
        VStack {
          Image("diary")
            .resizable()
            .scaledToFit()
            .frame(width: 80, height: 80)
          Text("Diary")
            .foregroundColor(.white)
            .font(.system(size: 20, weight: .bold))
        }
      }
      NavigationLink {
        VisualView(viewModel: InvestViewModel())
          .environment(\.colorScheme, .dark)
      } label: {
        VStack {
          Image("visual")
            .resizable()
            .scaledToFit()
            .frame(width: 80, height: 80)
          Text("Visual")
            .foregroundColor(.white)
            .font(.system(size: 24, weight: .bold))
        }
      }
    }
    
    HStack {
      NavigationLink {
        LessonsView(viewModel: LessonViewModel())
      } label: {
        VStack {
          Image("lessons")
            .resizable()
            .scaledToFit()
            .frame(width: 180, height: 150)
          Text("Lessons")
            .foregroundColor(.white)
            .font(.system(size: 28, weight: .bold))
        }
      }
    }
    
    HStack(spacing: 100) {
      NavigationLink {
        Currencies(viewModel: CurrencyViewModel())
      } label: {
        VStack {
          Image("currencies")
            .resizable()
            .scaledToFit()
            .frame(width: 80, height: 80)
          Text("Currencies")
            .foregroundColor(.white)
            .font(.system(size: 20, weight: .bold))
        }
      }
      NavigationLink {
        EventView()
          .environment(\.colorScheme, .dark)
      } label: {
        VStack {
          Image("events")
            .resizable()
            .scaledToFit()
            .frame(width: 80, height: 80)
          Text("Event")
            .foregroundColor(.white)
            .font(.system(size: 24, weight: .bold))
        }
      }
    }
  }
}


struct MainMenuView_Previews: PreviewProvider {
  static var previews: some View {
    MainMenuView()
  }
}
