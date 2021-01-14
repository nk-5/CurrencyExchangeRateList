//
//  ExchangeRate.swift
//  CurrencyExchangeRateList
//
//  Created by Keigo Nakagawa on 2021/01/10.
//

import Foundation

struct ExchangeRate: Hashable, Equatable {
    let source: String
    let target: String
    let rate: Double
    
    static func getExchangeRates(from liveExchangeRate: CurrencyLayerResponse.Live) -> [ExchangeRate] {
        let exchangeRates: [ExchangeRate] = liveExchangeRate.quotes.map { key, value in
            let target = key.replacingOccurrences(of: liveExchangeRate.source, with: "")
            return ExchangeRate(source: liveExchangeRate.source,
                         target: target,
                         rate: value)
        }

        return exchangeRates.sorted(by: {
            $0.target < $1.target
        })
    }
}

