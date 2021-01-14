//
//  CurrencylayerResponseData.swift
//  CurrencyExchangeRateList
//
//  Created by Keigo Nakagawa on 2021/01/10.
//

import Foundation

// refs: https://currencylayer.com/documentation

struct CurrencylayerResponseData {
    static var list: String {
        """
        {
            "success": true,
            "terms": "https://currencylayer.com/terms",
            "privacy": "https://currencylayer.com/privacy",
            "currencies": {
                "AED": "United Arab Emirates Dirham",
                "AFN": "Afghan Afghani",
                "ALL": "Albanian Lek",
                "AMD": "Armenian Dram",
                "ANG": "Netherlands Antillean Guilder"
            }
        }
        """
    }
    
    static var live: String {
        """
        {
            "success": true,
            "terms": "https://currencylayer.com/terms",
            "privacy": "https://currencylayer.com/privacy",
            "timestamp": 1610574874,
            "source": "USD",
            "quotes": {
                "USDAUD": 1.278342,
                "USDEUR": 1.278342,
                "USDGBP": 0.908019,
                "USDPLN": 3.731504
            }
        }
        """
    }
}
