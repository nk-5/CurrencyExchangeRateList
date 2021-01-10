//
//  CurrencylayerAPIClient.swift
//  CurrencyExchangeRateList
//
//  Created by Keigo Nakagawa on 2021/01/10.
//

import Foundation

struct CurrencylayerAPIClient: CurrencylayerAPIClientProtocol {
    func getCurrencies() -> [Currency] {
//        let jsonString = CurrencylayerResponseData.list
//        guard let currencyList = try? JSONDecoder().decode(CurrencyLayerResponse.List.self, from: jsonString.data(using: .utf8)!) else { return [] }
//
//        return Currency.getCurrencies(from: currencyList)
    }
    
    func getCurrencyRates(source: String) -> [ExchangeRate] {
//        let jsonString = CurrencylayerResponseData.live
//        guard let liveExchangeRate = try? JSONDecoder().decode(CurrencyLayerResponse.Live.self, from: jsonString.data(using: .utf8)!) else { return [] }
//
//        return ExchangeRate.getExchangeRates(from: liveExchangeRate)
    }
    
}
