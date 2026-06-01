import Foundation
import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @State private var individualCosts = 0.0
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Gesamtbetrag (in €)") {
                    TextField(
                        "Amount",
                        value: $checkAmount,
                        format: .currency(code: Locale.current.currency?.identifier ?? "USD")
                    )
                    .keyboardType(.decimalPad)
                    .focused($amountIsFocused)
                    
                    Picker("Number of Peoples", selection: $numberOfPeople) {
                        ForEach(1..<8) {
                            Text("\($0)  people")
                        }
                    }
                    .pickerStyle(.menu)
                }
                
                Section("Trinkgeld (in %)") {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text(String($0))
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Muss gezahlt werden (in €)") {
                    Text(individualCosts,format: .currency(code: Locale.current.currency?.identifier ?? "USD"
                                )
                    )
                }
                
                Button {
                    calculatingCosts()
                } label: {
                    Text("Berechne Kosten")
                        .font(.title3)
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
    
    
    private func calculatingCosts() {
        let peopleCount = Double(numberOfPeople + 1)
        let percentage = Double(tipPercentage) / 100.0
        let costPerPerson = checkAmount / peopleCount
        individualCosts = costPerPerson + (costPerPerson * percentage)
    }
}

#Preview {
    ContentView()
}


