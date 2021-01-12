//
//  ContentView.swift
//  CurrencyExchangeRateList
//
//  Created by Keigo Nakagawa on 2021/01/10.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var vm: MainViewModel
    
    let columns: [GridItem] = {
        let fixedSize = UIScreen.main.bounds.width / 3
        return [
            GridItem(.fixed(fixedSize), spacing: 2),
            GridItem(.fixed(fixedSize), spacing: 2),
            GridItem(.fixed(fixedSize), spacing: 2)
        ]
    }()

    init(vm: MainViewModel) {
        self.vm = vm
    }
    
    var body: some View {
        VStack(alignment: .trailing) {
            TextField("placeholder", text: self.$vm.currencyAmount, onCommit:  {
                UIApplication.shared.endEditing()
            })
            .keyboardType(.decimalPad)
            .multilineTextAlignment(.trailing)
            .padding()

            Menu {
                ForEach(vm.currencies) { currency in
                    Button(action: {
                        vm.selectedCurrency = currency
                    }) {
                        Label(currency.name, systemImage: currency.name == vm.selectedCurrency.name ? "checkmark" : "")
                    }
                }
            } label: {
                Text(vm.selectedCurrency.name)
                Image(systemName: "chevron.down")
            }
            .padding()
            
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(vm.exchangeRates, id: \.self) { item in
                        VStack {
                            Text(item.target)
                            Text("\(item.rate)")
                        }
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(vm: MainViewModel(currencyAPIClient: MockCurrencylayerAPIClient()))
    }
}
