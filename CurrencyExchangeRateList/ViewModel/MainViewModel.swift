//
//  MainViewModel.swift
//  CurrencyExchangeRateList
//
//  Created by Keigo Nakagawa on 2021/01/10.
//

import Combine

class MainViewModel: ObservableObject {
    @Published var currencyAmount: String = "100"
    @Published var selectedCurrency: Currency = Currency(name: "JPY")
    @Published var currencies: [Currency] = []
    @Published var exchangeRates: [ExchangeRate] = []

    // TODO: mock to prod
    private let currencyAPIClient: CurrencylayerAPIClientProtocol = MockCurrencylayerAPIClient()

    private var cancellableSet: Set<AnyCancellable> = []

    init() {
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
    }
}
