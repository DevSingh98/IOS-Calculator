# iOS Calculator

A modern iOS Calculator app built with Swift and SwiftUI following MVVM architecture patterns.

## Features

- **Clean MVVM Architecture**: Proper separation of Model, View, and ViewModel layers
- **Mathematical Symbols**: Uses proper Unicode symbols (×, ÷, −) for operations
- **Precision Handling**: Maintains full calculation precision while formatting display
- **Smart Number Formatting**: Automatically formats long decimals and removes trailing zeros
- **Responsive UI**: Adapts button sizing based on screen dimensions

## Architecture

### Model (`CalculatorModel.swift`)
- Contains data structures and business logic
- Defines button layouts and operation enums
- Handles mathematical operations

### ViewModel (`CalculatorViewModel.swift`)
- Manages application state using `@Published` properties
- Handles user interactions and business logic
- Formats display values while preserving calculation precision

### View (`ContentView.swift`)
- Pure UI presentation layer
- Observes ViewModel changes via `@StateObject`
- Responsive button layout with proper spacing

## Technical Highlights

- **State Management**: Uses SwiftUI's `ObservableObject` for reactive updates
- **Number Precision**: Separates display formatting from internal calculation values
- **Error Prevention**: Handles edge cases like division by zero and invalid inputs
- **Memory Efficient**: Minimal state management with proper cleanup

## Requirements

- iOS 14.0+
- Xcode 12.0+
- Swift 5.3+

## Upcoming Features

- **Scientific Calculator**: Landscape mode with advanced functions (sin, cos, tan, ln, log, √)
- **Memory Functions**: M+, M-, MR, MC operations
- **History**: View and reuse previous calculations
- **Themes**: Dark/Light mode support and custom color schemes
- **Haptic Feedback**: Tactile response for button presses

## Known Issues

- Decimal input validation needs improvement for edge cases
- Button animation could be smoother during rapid taps
- Display font size doesn't scale with accessibility settings

<img width="378" alt="Calculator Screenshot" src="https://user-images.githubusercontent.com/39712568/172404130-4b9e9277-b3d6-4413-94e7-86b2c41be0a9.png">
