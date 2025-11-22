//
//  CalculatorModel.swift
//  Calculator
//
//  Created by Deveshwar Singh on 11/21/25.
//  MVVM Architecture - Model Layer
//

import SwiftUI

enum CalcButton: String, CaseIterable {
    case one = "1", two = "2", three = "3", four = "4", five = "5"
    case six = "6", seven = "7", eight = "8", nine = "9", zero = "0"
    case add = "+", subtract = "−", multiply = "×", divide = "÷"
    case equal = "=", clear = "AC", decimal = ".", percent = "%", negative = "-/+"
    
    var buttonColor: Color {
        switch self {
        case .add, .subtract, .multiply, .divide, .equal:
            return .blue
        case .clear, .negative, .percent:
            return Color(.lightGray)
        default:
            return Color(.darkGray)
        }
    }
    
    var buttonTextColor: Color {
        switch self {
        case .clear, .negative, .percent:
            return .black
        default:
            return .white
        }
    }
}

enum Operation {
    case add, subtract, multiply, divide, none
}

struct CalculatorModel {
    var displayValue: String = "0"
    var runningNumber: Double = 0.0
    var currentOperation: Operation = .none
    
    let buttonLayout: [[CalcButton]] = [
        [.clear, .negative, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .subtract],
        [.one, .two, .three, .add],
        [.zero, .decimal, .equal]
    ]
    
    mutating func performOperation(_ operation: Operation, with currentValue: Double) -> Double {
        switch operation {
        case .add: return runningNumber + currentValue
        case .subtract: return runningNumber - currentValue
        case .multiply: return runningNumber * currentValue
        case .divide: return runningNumber / currentValue
        case .none: return currentValue
        }
    }
}
