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
            TransactionsView()
                .tabItem {
                    Label("Transactions", systemImage: "list.bullet")
                }
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
        
    }
}

#Preview {
    ContentView()
}
