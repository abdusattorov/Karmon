//
//  CurrenciesView.swift
//  Karmon
//
//  Created by Abdusamad Abdusattorov on 12/03/25.
//

import SwiftUI

struct CurrenciesView: View {
    @State private var selectedCurrency: String = getDefaultCurrency()
    
    let currencies = ["UZS", "USD", "EUR", "GBP", "PLN", "HUF", "KRW"]
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Currency Settings")) {
                    Picker("Select Default Currency", selection: $selectedCurrency) {
                        ForEach(currencies, id: \.self) { currency in
                            Text(currency)
                        }
                    }
                    .onChange(of: selectedCurrency) {
                        saveDefaultCurrency(currency: selectedCurrency)
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    CurrenciesView()
}
