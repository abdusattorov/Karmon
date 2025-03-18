//
//  CurrencyManager.swift
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

func getAllCurrencies() -> [String] {
    return ["UZS", "USD", "EUR", "GBP", "PLN", "HUF", "KRW"]
}

func currencyFormatter(for currencyCode: String) -> NumberFormatter {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.currencyCode = currencyCode
    formatter.minimumFractionDigits = 0
    formatter.maximumFractionDigits = 2
    return formatter
}

func formattedAmount(_ amount: Double, currencyCode: String) -> String {
    let formatter = currencyFormatter(for: currencyCode)
    return formatter.string(from: NSNumber(value: amount)) ?? "$0"
}
