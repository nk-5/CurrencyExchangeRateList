//
//  CurrencylayerResponse.swift
//  CurrencyExchangeRateList
//
//  Created by Keigo Nakagawa on 2021/01/10.
//

import Foundation

struct CurrencyLayerResponse {
    struct List: Decodable {
        let success: Bool
        let terms: String
        let privacy: String
        let currencies: [String: String]
    }
    
    struct Live: Decodable {
        let success: Bool
        let timestamp: Date
        let source: String
        let quotes: [String: Double]
    }
}
