//
//  FinCalculatorView.swift
//  Quantum
//
//  Created by Nikita Stshovsky on 15.09.2023.
//

import Foundation
import SwiftUI

struct FinCalculatorView: View {
    @State var initialDeposit = ""
    @State var years = ""
    @State var selected = 0
    @State var contribution = ""
    @State var rate = 5.0
    @AppStorage("key1")  var shouldshowonb = true
    
    var body: some View {
      
        ZStack {
            Color.black
                .ignoresSafeArea(.all)
            ScrollView(showsIndicators: false) {
                VStack(spacing:40){
                    VStack {
                        Text("Compound Interest").font(.largeTitle).foregroundColor(.white)
                        Spacer()
                    }.padding(.top,10)
                    ZStack {
                        VStack( spacing: 20) {
                            
                            RowView(binding: $initialDeposit, text: "Initialdeposit", placeHolder: "")
                            ContributionView(selected: $selected, contribution: $contribution,text: "Contribution", placeHolder: "")
                            StepperView(rate: $rate)
                            RowView(binding: $years, text: "Years", placeHolder: "")
                            HStack {
                                Text("Clear").onTapGesture {
                                    initialDeposit = ""
                                    contribution = ""
                                    rate = 5.0
                                    years = ""
                                }
                                Spacer()
                            }.padding(.leading,45)
                            
                            ZStack {
                                ButtonView()
                                if let _ = Double(initialDeposit) {
                                    if let _ = Double(years){
                                        
                                        if let b = Double(contribution) {
                                            
                                            
                                            NavigationLink("Calculate", destination:ListView(initialDeposit: initialDeposit, yearlyCont: selected == 0 ? 12*b:b, rate: rate, years: years)  )}
                                        else {
                                            NavigationLink("Calculate", destination:ListView(initialDeposit: initialDeposit, yearlyCont:0, rate: rate, years: years)  )
                                        }
                                        
                                    } else {
                                        Text("Calculate").foregroundColor(.white)
                                    } } else {
                                        Text("Calculate").foregroundColor(.white)
                                    }
                                
                            }.padding(.top,25)
                        }
                    }}
            }
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            Group {
                FinCalculatorView()
            }
        }
    }
    
    struct RowView: View {
        @Binding var binding : String
        var text : String
        var placeHolder : String
        var body: some View {
            
            ZStack {
                RecView()
                HStack{
                    
                    Text(LocalizedStringKey(text)).foregroundColor(.white)
                    TextField(LocalizedStringKey(placeHolder), text: $binding).foregroundColor(.white).keyboardType(.asciiCapableNumberPad)
                    
                }.padding(.horizontal,44)
            }
        }
    }
    
    struct ContributionView: View {
        @Binding var selected :Int
        @Binding var contribution :String
        var text : String
        var placeHolder : String
        
        var body: some View {
            ZStack {
                
                VStack {
                    Picker(selection: $selected, label: Text(":")) {
                        Text("Monthly")
                            .foregroundColor((selected != 0) ? .white : .blue)
                            .tag(0)
                        Text("Yearly")
                            .foregroundColor((selected != 0) ? .white : .blue)
                            .tag(1)
                    }.pickerStyle(SegmentedPickerStyle()).frame(width: 330, height: 50, alignment: .center).padding(.horizontal,20)
                    
                    HStack {
                        Text(LocalizedStringKey(text)).foregroundColor(.white)
                        TextField(LocalizedStringKey(placeHolder), text: $contribution)}.padding(.horizontal,45).keyboardType(.asciiCapableNumberPad).foregroundColor(.white)
                }
                RecView().padding(.top,60)
            }
        }
    }
    
    struct StepperView: View {
        @Binding var rate:Double
        var num:String {
            return "\(rate)"
        }
        var body: some View {
            ZStack {
                VStack(alignment:.leading) {
                    Spacer()
                    Rectangle().frame(width: 230, height: 1)
                }.padding(.top,25).padding(.trailing,100)
                Stepper(value: $rate, in: 0.25...20 , step: 0.25) {
                    HStack {
                        Text("Rate %")
                        Text(num)
                    }.foregroundColor(.white)
                }.padding(.horizontal,45)
            }
        }
    }
    
    struct RecView: View {
        var body: some View {
            
            
            VStack {
                Spacer()
                Rectangle().frame(width: 330, height: 1, alignment: .bottom)
            }.padding(.top,25)
            
        }
    }
}


struct ButtonView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 25, style: .continuous).frame(width: 340, height: 40, alignment: .center).foregroundColor(Color.black)
            .opacity(0.3).overlay( RoundedRectangle(cornerRadius: 25, style: .continuous).stroke().foregroundColor(.white)).overlay(Text("Calculate")).foregroundColor(.white)
    }
}




struct ListView :View {
    var initialDeposit: String
    var yearlyCont: Double
    var rate: Double
    var years: String
    
    static  var  PreviousAmount = 0.0
    
    var body: some View {
        
        ZStack {
            Color.black
                .ignoresSafeArea(.all)
            
            ScrollView(showsIndicators: false) {
                VStack {
                    HStack{
                        
                        Text("Year")
                        Spacer()
                        Text("Compounded")
                        Spacer()
                        
                    }.foregroundColor(.white).padding()
                    ForEach(1..<Int(years)!  + 1){i in
                        
                        
                        let f: Double = calc(initialDeposit: Double(initialDeposit)!, PreviousAmount: ListView.PreviousAmount, yearlyCont: yearlyCont, rate: rate, years: i)
                        let str = String(format: "%.1f", f)
                        
                        HStack {
                            Text("\(String(i))")
                            Spacer()
                            Text("\(str)")
                            Spacer()
                        }.foregroundColor(.white).padding()
                        
                    }
                }
            }
        }.onDisappear(perform: onDisappear)
    }
    func onDisappear() {
        ListView.PreviousAmount = 0
    }
    func calc(initialDeposit :Double,
              PreviousAmount:Double,
              yearlyCont : Double,
              rate:Double,
              years:Int) -> Double {
        
        if years == 1 {
            let a = initialDeposit*(1+rate/100)+yearlyCont
            ListView.PreviousAmount = a
            return a
        }
        let b = PreviousAmount*(1+rate/100)+yearlyCont
        ListView.PreviousAmount = b
        return b
        
    }
    
}
