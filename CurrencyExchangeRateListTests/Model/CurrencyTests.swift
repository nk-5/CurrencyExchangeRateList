//
//  CurrencyTests.swift
//  CurrencyExchangeRateListTests
//
//  Created by Keigo Nakagawa on 2021/01/10.
//

import XCTest
@testable import CurrencyExchangeRateList

class CurrencyTests: XCTestCase {
    func testGetCurrencies() throws {
        let jsonString =
            """
            {
                "success": true,
                "terms": "https://currencylayer.com/terms",
                "privacy": "https://currencylayer.com/privacy",
                "currencies": {
                    "AED": "United Arab Emirates Dirham"
                }
            }
            """
        
        let currencyList = try? JSONDecoder().decode(CurrencyLayerResponse.List.self, from: jsonString.data(using: .utf8)!)

        let currencies = Currency.getCurrencies(from: currencyList!)
       
        XCTAssertEqual("AED", currencies.first?.name)
        XCTAssertEqual("United Arab Emirates Dirham", currencies.first?.fullName)
        XCTAssertEqual("AED", currencies.first?.id)
    }
}
