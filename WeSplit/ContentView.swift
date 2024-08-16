//
//  ContentView.swift
//  WeSplit
//
//  Created by Tony Chang on 8/12/24.
//

import SwiftUI

struct ContentView: View {
    @FocusState private var amountIsFocused: Bool
    
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    
    let tipPercentages = [ 10, 15, 20, 25, 0 ]

    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        let tipAmount = checkAmount / 100 * tipSelection
        let grandTotal = tipAmount + checkAmount
        return grandTotal / peopleCount
    }
    
    var checkTotal: Double {
        let tipSelection = Double(tipPercentage)
        let tipAmount = checkAmount / 100 * tipSelection
        return tipAmount + checkAmount
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format:
                            .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    .keyboardType(.decimalPad)
                    .focused($amountIsFocused)
                    
                    Picker("Number of People", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                    .pickerStyle(.navigationLink)
                }

//                Section("How much do you want to tip?") {
//                    Picker("Percent", selection: $tipPercentage) {
//                        ForEach(0..<101) {
//                            Text("\($0)%")
//                        }
//                    }
//                }
                
                Section("How much do you want to tip?") {
                    Picker("Tip Percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                }

                Section("Check Amount:") {
                    Text("\(checkTotal)")
                        .foregroundColor((tipPercentage == 0) ? .red : .black)
                }

                Section("Amount per Person") {
                    Text("\(totalPerPerson)")
                        .foregroundColor((tipPercentage == 0) ? .red : .black)
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
