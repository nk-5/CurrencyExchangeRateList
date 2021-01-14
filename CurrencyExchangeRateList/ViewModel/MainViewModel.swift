//
//  MainViewModel.swift
//  CurrencyExchangeRateList
//
//  Created by Keigo Nakagawa on 2021/01/10.
//

import Combine
import Foundation

class MainViewModel: ObservableObject {
    @Published var currencyAmount: String = "100"
    @Published var selectedCurrency: Currency = Currency(name: "JPY")
    @Published var currencies: [Currency] = []
    @Published var exchangeRates: [ExchangeRate] = []

    private let currencyAPIClient: CurrencylayerAPIClientProtocol

    private var cancellableSet: Set<AnyCancellable> = []

    init(currencyAPIClient: CurrencylayerAPIClientProtocol = CurrencylayerAPIClient()) {
        self.currencyAPIClient = currencyAPIClient
        
        currencyAPIClient.getCurrencies()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    // TODO: error handling
                break
                case .finished: break
                }
            }, receiveValue: {
                self.currencies = $0
            })
            .store(in: &cancellableSet)
        
        exchangeRates = currencyAPIClient.getCurrencyRates(source: "USD")
       
        $selectedCurrency
            .debounce(for: 0.8, scheduler: RunLoop.main)
            .dropFirst()
            .removeDuplicates()
            .map { input -> [ExchangeRate] in
                currencyAPIClient.getCurrencyRates(source: input.name)
            }
            .receive(on: DispatchQueue.main)
            .assign(to: \.exchangeRates, on: self)
            .store(in: &cancellableSet)
    }
}
