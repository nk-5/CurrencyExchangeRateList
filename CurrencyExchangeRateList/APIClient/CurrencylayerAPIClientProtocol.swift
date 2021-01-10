//
//  CurrencylayerAPIClientProtocol.swift
//  CurrencyExchangeRateList
//
//  Created by Keigo Nakagawa on 2021/01/10.
//

import Foundation
import Combine

protocol CurrencylayerAPIClientProtocol {
    func getCurrencies() -> Future<[Currency], CurrencylayerAPIError>
    func getCurrencyRates(source: String) -> [ExchangeRate]
}
