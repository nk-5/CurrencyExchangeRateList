//
//  Currency.swift
//  CurrencyExchangeRateList
//
//  Created by Keigo Nakagawa on 2021/01/10.
//

import Foundation

struct Currency: Identifiable, Hashable, Equatable, Decodable {
    let name: String
    var fullName: String = ""
    
    var id: String { name }
    
    static func getCurrencies(from currencyList: CurrencyLayerResponse.List) -> [Currency] {
        return currencyList.currencies.map { key, value in
           Currency(name: key, fullName: value)
        }
    }
}

