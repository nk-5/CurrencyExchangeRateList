//
//  CurrencyExchangeRateListApp.swift
//  CurrencyExchangeRateList
//
//  Created by Keigo Nakagawa on 2021/01/10.
//

import SwiftUI

@main
struct CurrencyExchangeRateListApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(vm: MainViewModel())
        }
    }
}
