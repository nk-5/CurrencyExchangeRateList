//
//  CurrencylayerAPIClientTests.swift
//  CurrencyExchangeRateListTests
//
//  Created by Keigo Nakagawa on 2021/01/14.
//

import XCTest
@testable import CurrencyExchangeRateList

class CurrencylayerAPIClientTests: XCTestCase {
    override func tearDown() {
        UserDefaults.standard.clearAll()
    }
    
    func testGetCurrencyRates_whenUseCache() throws {
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
        
        let liveExchangeRate = try JSONDecoder().decode(CurrencyLayerResponse.Live.self, from: jsonString.data(using: .utf8)!)

        UserDefaults.standard.setCurrencyRateTimeStamp(timestamp: Date())
        UserDefaults.standard.setTargetCurrencyRateSource(source: "USD")
        UserDefaults.standard.setCurrencyRates(currencyRates: liveExchangeRate.quotes)
       
        let apiClient = CurrencylayerAPIClient()
        let exchangeRates = apiClient.getCurrencyRates(source: "USD")

        XCTAssertEqual(1, exchangeRates.count)
        XCTAssertEqual("USD", exchangeRates.first!.source)
        XCTAssertEqual("AUD", exchangeRates.first!.target)
    }
    
    func testGetCurrencyRates_whenNotUseCache() throws {
        let apiClient = CurrencylayerAPIClient()
        let exchangeRates = apiClient.getCurrencyRates(source: "USD")

        XCTAssertEqual(4, exchangeRates.count)
        XCTAssertEqual("USD", exchangeRates.first!.source)
        XCTAssertEqual("AUD", exchangeRates.first!.target)
    }
}
