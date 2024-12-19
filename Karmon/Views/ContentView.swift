//
//  ContentView.swift
//  Karmon
//
//  Created by Abdusamad Abdusattorov on 09/12/24.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        TabView {
            Tab("Transactions", systemImage: "list.bullet.rectangle.fill") {
                TransactionsView()
            }
            Tab("Statistics", systemImage: "chart.pie.fill") {
                StatisticsView()
            }
            Tab("Settings", systemImage: "gear") {
                SettingsView()
            }
        }
    }
}

#Preview {
    ContentView()
}
