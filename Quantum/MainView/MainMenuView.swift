//
//  MainMenuView.swift
//  Quantum
//
//  Created by Nikita Stshovsky on 20.07.2023.
//

import SwiftUI

struct MainMenuView: View {
  var body: some View {
    NavigationView {
    ZStack {
      Color.black
        .ignoresSafeArea()
      Image("backgroundImage")
        .resizable()
        .scaledToFill()
        .ignoresSafeArea()
      VStack {
        HStack {
          Image("quantumAI")
            .resizable()
            .scaledToFit()
            .frame(width: 160, height: 160)
        }.padding(.trailing, 180)
        Spacer()
        menuButtons()
          .padding(.trailing, 40)
          .padding(.bottom, 120)
      }
    }
  }
    }
  }
  
  @ViewBuilder private func menuButtons() -> some View {
    VStack {
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
        NavigationLink {
          SettingsView()
        } label: {
          VStack {
            Image("settings")
              .resizable()
              .scaledToFit()
              .frame(width: 80, height: 80)
            Text("Settings")
              .foregroundColor(.white)
              .font(.system(size: 20, weight: .bold))
          }
        }
        
      }
      HStack(spacing: 40) {
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
              .frame(width: 140, height: 120)
            Text("Visual")
              .foregroundColor(.white)
              .font(.system(size: 24, weight: .bold))
          }
        }
      }.padding(.leading, 80)
    }
  }


struct MainMenuView_Previews: PreviewProvider {
  static var previews: some View {
    MainMenuView()
  }
}
