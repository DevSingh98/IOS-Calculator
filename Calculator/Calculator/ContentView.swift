//
//  ContentView.swift
//  Calculator
//
//  Created by Deveshwar Singh on 11/21/25.
//  MVVM Architecture - View Layer
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = CalculatorViewModel()
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack {
                Link("Created by Deveshwar Singh", destination: URL(string: "https://www.deveshwarsingh.com")!)
                    .font(.system(size: 12))
                Spacer()
                
                HStack {
                    Spacer()
                    Text(viewModel.displayValue)
                        .bold()
                        .font(.system(size: 95))
                        .foregroundColor(.white)
                }
                .padding()
                
                ForEach(viewModel.buttonLayout, id: \.self) { row in
                    HStack(spacing: 12) {
                        ForEach(row, id: \.self) { button in
                            Button(action: {
                                viewModel.buttonTapped(button)
                            }) {
                                Text(button.rawValue)
                                    .font(.system(size: 32))
                                    .frame(width: buttonWidth(button), height: buttonHeight())
                                    .background(button.buttonColor)
                                    .foregroundColor(button.buttonTextColor)
                                    .cornerRadius(buttonWidth(button) / 2)
                            }
                            .frame(width: buttonWidth(button), height: buttonHeight())
                        }
                    }
                    .padding(.bottom, 3)
                }
            }
        }
    }
    
    private func buttonWidth(_ button: CalcButton) -> CGFloat {
        if button == .zero {
            return ((UIScreen.main.bounds.width - (5*6))/4)*2
        }
        return (UIScreen.main.bounds.width - (5*12))/4
    }
    
    private func buttonHeight() -> CGFloat {
        return (UIScreen.main.bounds.width - (5*12))/4
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
