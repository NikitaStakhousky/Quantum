//
//  FirstLessonView.swift
//  Quantum
//
//  Created by Nikita Stshovsky on 15.09.2023.
//

import SwiftUI

struct FirstLessonView: View {
 
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
          Text("Lesson 1")
            .font(.system(size: 34, weight: .bold))
            .frame(width: 280, height: 54)
            .foregroundColor(.white)
            .cornerRadius(12)
            .overlay(
              RoundedRectangle(cornerRadius: 28)
                .stroke(Color.white, lineWidth: 2)
                .shadow(color: .white, radius: 6)
            )
          Image("firstLesson")
              .resizable()
              .scaledToFit()
              .frame(width: 340, height: 340)
              .shadow(color: .white, radius: 6)
          
          Text("Trading is the act of buying and selling financial instruments, such as stocks, bonds, commodities, and currencies. The goal of trading is to make a profit by taking advantage of price movements in the market. Traders use various strategies and techniques to analyze market trends and make informed decisions about when to buy and sell. Some common types of trading include day trading, swing trading, and position trading. Trading can be done through a broker or on an exchange, and can be done by individuals or institutions.Trading involves risk, as the value of financial instruments can fluctuate due to a variety of factors, including changes in market conditions, economic news, and company performance. Successful traders are able to manage risk by diversifying their investments and using tools such as stop-loss orders to limit potential losses.There are many resources available to help individuals learn about trading and develop their skills. These include books, online courses, and seminars. It is important for traders to stay up-to-date with market news and trends, and to continually educate themselves in order to make informed decisions.In summary, trading is the act of buying and selling financial instruments with the goal of making a profit. It involves risk, but can be a rewarding endeavor for those who are willing to put in the time and effort to learn about the markets and develop their skills.")
            .foregroundColor(.white)
            .font(.system(size: 24, weight: .bold))
            .frame(width: 340)
            .padding()
        }
      }
    }
  }
}

