//  ContentView.swift
//  WeSplit
//  Created by Spencer Jones on 6/14/25

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var amountOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountisFocused: Bool
    
    let tipPercentages = [0, 10, 15, 20, 25, 30]
    
    var totalTip: Double {
        let tipSelection = Double(tipPercentage)
        return checkAmount / 100 * tipSelection
    }
    
    var grandTotal: Double {
        return checkAmount + totalTip
    }
    
    var totalPerPerson: Double {
        let peopleCount = Double(amountOfPeople)
        let amountPerPerson = grandTotal / peopleCount
        return amountPerPerson
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    
                    // Check Amount Card
                    cardView {
                        VStack(spacing: 12) {
                            HStack {
                                Text("Check Amount")
                                    .font(.headline)
                                    .foregroundColor(.secondary)
                                Spacer()
                            }
                            
                            TextField("$0.00", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                                .keyboardType(.decimalPad)
                                .focused($amountisFocused)
                                .font(.largeTitle.bold())
                                .multilineTextAlignment(.center)
                                .foregroundColor(.blue)
                        }
                    }
                    
                    // Number of People Card
                    cardView {
                        VStack(spacing: 12) {
                            HStack {
                                Image(systemName: "person.2.fill")
                                    .foregroundColor(.secondary)
                                Text("Number of People")
                                    .font(.headline)
                                    .foregroundColor(.secondary)
                                Spacer()
                            }
                            
                            HStack(spacing: 30) {
                                circularButton(systemName: "minus") {
                                    if amountOfPeople > 1 {
                                        amountOfPeople -= 1
                                    }
                                }
                                .disabled(amountOfPeople <= 1)
                                
                                Text("\(amountOfPeople)")
                                    .font(.largeTitle.bold())
                                    .frame(minWidth: 50)
                                
                                circularButton(systemName: "plus") {
                                    if amountOfPeople < 20 {
                                        amountOfPeople += 1
                                    }
                                }
                                .disabled(amountOfPeople >= 20)
                            }
                        }
                    }
                    
                    // Tip Percentage Card
                    cardView {
                        VStack(spacing: 12) {
                            HStack {
                                Text("Tip Percentage")
                                    .font(.headline)
                                    .foregroundColor(.secondary)
                                Spacer()
                            }
                            
                            Picker("Tip Percentage", selection: $tipPercentage) {
                                ForEach(tipPercentages, id: \.self) {
                                    Text($0, format: .percent)
                                }
                            }
                            .pickerStyle(.segmented)
                        }
                    }
                    
                    // Result Card
                    resultCard {
                        VStack(spacing: 16) {
                            Text("Total Per Person")
                                .font(.headline)
                                .foregroundColor(.white.opacity(0.9))
                            
                            Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                                .font(.system(size: 36, weight: .bold, design: .rounded))
                                .foregroundColor(.white)
                            
                            Divider()
                                .background(.white.opacity(0.3))
                            
                            HStack(spacing: 0) {
                                breakdownItem(title: "Bill", amount: checkAmount)
                                breakdownItem(title: "Tip", amount: totalTip)
                                breakdownItem(title: "Total", amount: grandTotal)
                            }
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("WeSplit")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                if amountisFocused {
                    ToolbarItem(placement: .keyboard) {
                        Button("Done") {
                            amountisFocused = false
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
