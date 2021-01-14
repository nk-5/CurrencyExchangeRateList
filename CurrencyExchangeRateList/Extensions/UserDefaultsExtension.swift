//
//  UserDefaultsExtension.swift
//  CurrencyExchangeRateList
//
//  Created by Keigo Nakagawa on 2021/01/13.
//

import Foundation

enum UserDefaultsKey: String, CaseIterable {
    case currencyRateRequestTimestamp
    case targetCurrencyRateSource
    case currencyRates
}

extension UserDefaults {
    func save(object: Any, key: String) {
        set(object, forKey: key)
        synchronize()
    }

    func object<T>(key: String, defaultValue: T) -> T {
        if object(forKey: key) == nil {
            save(object: defaultValue, key: key)
            return defaultValue
        }

        if defaultValue is String {
            return string(forKey: key) as! T
        }

        if defaultValue is Int {
            return integer(forKey: key) as! T
        }

        if defaultValue is Bool {
            return bool(forKey: key) as! T
        }

        if defaultValue is [Any] {
            return array(forKey: key) as! T
        }

        if defaultValue is [String: Any] {
            return dictionary(forKey: key) as! T
        }

        return object(forKey: key) as! T
    }
    
    func clearAll() {
        UserDefaultsKey.allCases.forEach {
            removeObject(forKey: $0.rawValue)
        }
    }
}

extension UserDefaults {
    var currencyRateTimeStamp: Date? {
        return UserDefaults.standard.object(forKey: UserDefaultsKey.currencyRateRequestTimestamp.rawValue) as? Date
    }
    
    var targetCurrencyRateSource: String? {
        return UserDefaults.standard.object(forKey: UserDefaultsKey.targetCurrencyRateSource.rawValue) as? String
    }
    
    var currencyRates: CurrencyRates? {
        return UserDefaults.standard.object(forKey: UserDefaultsKey.currencyRates.rawValue) as? CurrencyRates
    }
    
    func setCurrencyRateTimeStamp(timestamp: Date) {
        set(timestamp, forKey: UserDefaultsKey.currencyRateRequestTimestamp.rawValue)
    }
    
    func setTargetCurrencyRateSource(source: String) {
        set(source, forKey: UserDefaultsKey.targetCurrencyRateSource.rawValue)
    }
    
    func setCurrencyRates(currencyRates: CurrencyRates) {
        set(currencyRates, forKey: UserDefaultsKey.currencyRates.rawValue)
    }
}
