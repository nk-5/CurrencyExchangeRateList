//
//  CurrencylayerAPIClientProtocol.swift
//  CurrencyExchangeRateList
//
//  Created by Keigo Nakagawa on 2021/01/10.
//

import Foundation

protocol CurrencylayerAPIClientProtocol {
    func getCurrencies() -> [Currency]
    func getCurrencyRates(source: String) -> [ExchangeRate]
}
