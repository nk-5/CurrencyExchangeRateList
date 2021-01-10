//
//  ExchangeRateTests.swift
//  CurrencyExchangeRateListTests
//
//  Created by Keigo Nakagawa on 2021/01/10.
//

import XCTest
@testable import CurrencyExchangeRateList

class ExchangeRateTests: XCTestCase {
    func testGetExchangeRates() throws {
        let jsonString =
            """
            {
                "success": true,
                "terms": "https://currencylayer.com/terms",
                "privacy": "https://currencylayer.com/privacy",
                "timestamp": 1432400348,
                "source": "USD",
                "quotes": {
                    "USDAUD": 1.278342
                }
            }
            """
        
        let liveExchangeRate = try? JSONDecoder().decode(CurrencyLayerResponse.Live.self, from: jsonString.data(using: .utf8)!)

        let exchangeRates = ExchangeRate.getExchangeRates(from: liveExchangeRate!)
       
        XCTAssertEqual("USD", exchangeRates.first?.source)
        XCTAssertEqual("AUD", exchangeRates.first?.target)
        XCTAssertEqual(1.278342, exchangeRates.first?.rate)
    }
}
