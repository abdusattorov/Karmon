//
//  DefaultCurrencyManager.swift
//  Karmon
//
//  Created by Abdusamad Abdusattorov on 12/03/25.
//

import Foundation

private let defaultCurrencyKey = "defaultCurrency"

func saveDefaultCurrency(currency: String) {
    UserDefaults.standard.set(currency, forKey: defaultCurrencyKey)
}

func getDefaultCurrency() -> String {
    return UserDefaults.standard.string(forKey: defaultCurrencyKey) ?? "USD"
}
