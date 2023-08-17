//
//  EventView.swift
//  Quantum
//
//  Created by Nikita Stshovsky on 15.08.2023.
//

import SwiftUI

struct EventView: View {
  @StateObject var viewModel: EventViewModel
  @State var userName: String = ""
  @State var mail: String = ""
  
  var body: some View {
    ZStack {
      Color.black
        .ignoresSafeArea()
      Image("backgroundImage")
        .resizable()
        .scaledToFill()
        .ignoresSafeArea()
      VStack {
        Text("Events")
          .font(.system(size: 40, weight: .bold))
          .foregroundColor(.white)
        AsyncImage(url: URL(string: "http://65.108.243.149/1/image9.jpg")) { image in
          image
            .resizable()
            .scaledToFit()
            .frame(width: 340, height: 340)
            .shadow(color: .white, radius: 6)
        } placeholder: {
          ProgressView()
            .background(Color.black)
            .frame(width: 340, height: 340)
        }
        VStack {
          Text("Quantum AI is proud to announce a new lecture series on investing in stocks and cryptocurrencies.")
            .foregroundColor(.white)
            .font(.system(size: 18, weight: .bold))
            .multilineTextAlignment(.center)
          Text("This course will provide you with the knowledge and tools you need to make informed investment decisions in these exciting and rapidly evolving markets.")
            .multilineTextAlignment(.center)
            .foregroundColor(.white)
            .font(.system(size: 12, weight: .bold))
        }.padding(.top, -20)
          .frame(width: 370)
        TextField("Name", text: $userName)
          .modifier(customViewModifier(roundedCornes: 18, startColor: .white, endColor: .white, color: Color.white, textColor: .black))
          .frame(width: 300, height: 40)
          .padding(.top, 20)
        TextField("Mail", text: $mail)
          .modifier(customViewModifier(roundedCornes: 18, startColor: .white, endColor: .white, color: Color.white, textColor: .black))
          .frame(width: 300, height: 40)
          .padding(.top, 20)
        Button {
          viewModel.showAlert.toggle()
          userName = ""
          mail = ""
        } label: {
          Text("Register")
            .foregroundColor(.black)
            .frame(width: 300, height: 40)
            .background {
              Rectangle()
              Color.white
            }
            .cornerRadius(18)
            .shadow(color: .white, radius: 4)
        }
        .padding(.top, 20)
        .alert("Thank you we will send you an invitation", isPresented: $viewModel.showAlert) {
          Button("Ok", role: .cancel) {}
        }
      }
    }
    .onAppear {
      viewModel.getEvent()
    }
  }
}

struct customViewModifier: ViewModifier {
  var roundedCornes: CGFloat
  var startColor: Color
  var endColor: Color
  var color: Color
  var textColor: Color
  
  func body(content: Content) -> some View {
    content
      .padding()
      .background(color)
      .cornerRadius(roundedCornes)
      .padding(3)
      .foregroundColor(textColor)
      .overlay(RoundedRectangle(cornerRadius: roundedCornes)
        .stroke(LinearGradient(gradient: Gradient(colors: [startColor, endColor]), startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 2.5))
      .font(.custom("", size: 18))
    
      .shadow(color: .white, radius: 4)
  }
}

struct EventView_Previews: PreviewProvider {
  static var previews: some View {
    EventView(viewModel: EventViewModel())
  }
}
