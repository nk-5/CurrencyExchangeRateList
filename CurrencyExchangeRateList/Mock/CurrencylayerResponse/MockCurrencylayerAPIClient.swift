//
//  MockCurrencylayerAPIClient.swift
//  CurrencyExchangeRateList
//
//  Created by Keigo Nakagawa on 2021/01/10.
//

import Foundation
import Combine

struct MockCurrencylayerAPIClient: CurrencylayerAPIClientProtocol {
    func getCurrencies() -> Future<[Currency], CurrencylayerAPIError> {
        return Future<[Currency], CurrencylayerAPIError> { promise in
            let jsonString = CurrencylayerResponseData.list
            guard let currencyList = try? JSONDecoder().decode(CurrencyLayerResponse.List.self, from: jsonString.data(using: .utf8)!) else {
                promise(.failure(.decodeError))
                return
            }

            promise(.success(Currency.getCurrencies(from: currencyList)))
        }
    }

    func getCurrencyRates(source: String) -> [ExchangeRate] {
        let jsonString = CurrencylayerResponseData.live
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        
        guard let liveExchangeRate = try? decoder.decode(CurrencyLayerResponse.Live.self, from: jsonString.data(using: .utf8)!) else { return [] }

        return ExchangeRate.getExchangeRates(from: liveExchangeRate)
    }
    
}
