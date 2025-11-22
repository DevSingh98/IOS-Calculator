//
//  CalculatorViewModel.swift
//  Calculator
//
//  Created by Deveshwar Singh on 11/21/25.
//  MVVM Architecture - ViewModel Layer
//

import Foundation
import SwiftUI

class CalculatorViewModel: ObservableObject {
    @Published private var model = CalculatorModel()
    private var actualValue: Double = 0
    private var shouldResetDisplay = false
    
    var displayValue: String {
        model.displayValue
    }
    
    var buttonLayout: [[CalcButton]] {
        model.buttonLayout
    }
    
    func buttonTapped(_ button: CalcButton) {
        switch button {
        case .add, .subtract, .multiply, .divide:
            handleOperation(button)
        case .equal:
            calculateResult()
        case .clear:
            clearCalculator()
        case .percent:
            applyPercent()
        case .decimal:
            addDecimal()
        case .negative:
            toggleSign()
        default:
            addNumber(button.rawValue)
        }
    }
    
    private func handleOperation(_ button: CalcButton) {
        actualValue = Double(model.displayValue) ?? 0
        model.runningNumber = actualValue
        model.currentOperation = operationFromButton(button)
        shouldResetDisplay = true
    }
    
    private func calculateResult() {
        let currentValue = Double(model.displayValue) ?? 0
        let result = model.performOperation(model.currentOperation, with: currentValue)
        actualValue = result
        model.displayValue = formatForDisplay(result)
        model.currentOperation = .none
        shouldResetDisplay = true
    }
    
    private func clearCalculator() {
        model.displayValue = "0"
        model.runningNumber = 0.0
        model.currentOperation = .none
        actualValue = 0
        shouldResetDisplay = false
    }
    
    private func applyPercent() {
        actualValue = actualValue / 100
        model.displayValue = formatForDisplay(actualValue)
    }
    
    private func addDecimal() {
        if !model.displayValue.contains(".") {
            model.displayValue += "."
        }
    }
    
    private func toggleSign() {
        actualValue = -actualValue
        model.displayValue = formatForDisplay(actualValue)
    }
    
    private func addNumber(_ number: String) {
        if model.displayValue == "0" || shouldResetDisplay {
            model.displayValue = number
            shouldResetDisplay = false
        } else {
            model.displayValue += number
        }
        actualValue = Double(model.displayValue) ?? 0
    }
    
    private func operationFromButton(_ button: CalcButton) -> Operation {
        switch button {
        case .add: return .add
        case .subtract: return .subtract
        case .multiply: return .multiply
        case .divide: return .divide
        default: return .none
        }
    }
    
    
    private func formatForDisplay(_ value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 8
        formatter.minimumFractionDigits = 0
        formatter.numberStyle = .decimal
        
        let formatted = formatter.string(from: NSNumber(value: value)) ?? "0"
        return formatted.count > 9 ? String(formatted.prefix(9)) : formatted
    }
}
