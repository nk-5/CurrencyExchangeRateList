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

    private let currencyAPIClient: CurrencylayerAPIClientProtocol = MockCurrencylayerAPIClient()

    private var cancellableSet: Set<AnyCancellable> = []

    init() {
        currencies = currencyAPIClient.getCurrencies()
        exchangeRates = currencyAPIClient.getCurrencyRates(source: "USD")
//        $name
//            .debounce(for: 0.8, scheduler: RunLoop.main)
//            .removeDuplicates()
//            .map { input in
//                return input.count > 2
//            }
//            .assign(to: \.isValid, on: self)
//            .store(in: &cancellableSet)
    }
}
