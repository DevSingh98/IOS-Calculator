//
//  ContentView.swift
//  Calculator
//
//  Created by Deveshwar Singh on 6/6/22.
//

import SwiftUI

enum CalcButton: String{
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case zero = "0"
    case add = "+"
    case subtract = "-"
    case multiply = "*"
    case divide = "/"
    case equal = "="
    case clear = "AC"
    case decimal = "."
    case percent = "%"
    case negative = "-/+"
    
    var buttonColor: Color {
        switch self {
        case .add, .subtract, .multiply, .divide, .equal:
            return .orange
        case .clear, .negative, .percent:
            return Color(.lightGray)
        default:
            return Color(.darkGray)
        }
    }
}

enum Operation {
    case add, subtract, multiply, divide, none
    
    
}

struct ContentView: View {
    
    @State var value = "0"
    
    @State var runningNumber = 0
    //Is a state variable since regular vars are immutable inside views
    @State var currentOperation: Operation = .none
    
    let buttons: [[CalcButton]] = [
        [.clear, .negative, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .subtract],
        [.one, .two, .three, .add],
        [.zero, .decimal, .equal]
    ]
    
    var body: some View {
        ZStack{
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack{
                Spacer()
                //Text Display
                HStack{
                    Spacer()
                    Text(value)
                        .bold()
                        .font(.system(size: 95))
                        .foregroundColor(.white)
                }
                .padding()
                
                //Buttons
                ForEach(buttons, id: \.self){ row in
                    HStack(spacing: 12){
                        ForEach(row, id: \.self){ item in
                            Button(action: { //Action for when a button is clicked
                                self.didTap(button: item)
                            }, label: {
                                Text(item.rawValue)
                                    .font(.system(size: 32)) //Button font size
                                    .frame(width: self.buttonWidth(item: item), height: self.buttonHeight()) //Button height and width
                                    .background(item.buttonColor) //Button background color
                                    .foregroundColor(.white) //Button font color
                                    .cornerRadius(self.buttonWidth(item: item)/2) //Makes the Button round
                            })
                        }
                    }
                    .padding(.bottom,3)
                }
            }
        }
    }
    
    //Function for button tap action
    func didTap(button: CalcButton) {
        switch button { //if button is a operation we will store the operation of the current state and current value
        case .add, .subtract, .multiply, .divide, .equal:
            if button == .add{
                self.currentOperation = .add
                self.runningNumber = Int(self.value) ?? 0
            }
            else if button == .subtract{
                self.currentOperation = .subtract
                self.runningNumber = Int(self.value) ?? 0
            }
            else if button == .multiply{
                self.currentOperation = .multiply
                self.runningNumber = Int(self.value) ?? 0
            }
            else if button == .divide{
                self.currentOperation = .divide
                self.runningNumber = Int(self.value) ?? 0
            }
            else if button == .equal{ // if operation is equal, we take the current value and apply the opperation to it
                let runningValue = self.runningNumber
                let currentValue = Int(self.value) ?? 0
                switch self.currentOperation{
                    case .add: self.value = "\(runningValue + currentValue)"
                    case .subtract: self.value = "\(runningValue - currentValue)"
                    case .multiply: self.value = "\(runningValue * currentValue)"
                    case .divide: self.value = "\(runningValue / currentValue)"
                    case .none:
                        break
                }
            }
            
            if button != .equal { //clear text back to default (0)
                self.value = "0"
            }
        case .clear:
            self.value = "0"
        case .decimal, .negative, .percent:
            break
        default:// button is a number so number will display self
            let number = button.rawValue
            if self.value == "0" {
                value = number
            }
            else{//used string to append number to the end instead of *10 + value
                self.value = "\(self.value)\(number)"
            }
        }
    }
    
    //Function to calculate button width based on screen size (Take the width of the screen, subtract the padding between each column and then divide by the number of columns we have)
    func buttonWidth(item: CalcButton) -> CGFloat {
        if item == .zero {//special case for 0 since we want zero to take up two columns
            return ((UIScreen.main.bounds.width - (5*12))/4)*2
        }
        return (UIScreen.main.bounds.width - (5*12))/4
    }
    
    //Function to calculate button height based on screen size
    func buttonHeight()-> CGFloat{
        return (UIScreen.main.bounds.width - (5*12))/4
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
