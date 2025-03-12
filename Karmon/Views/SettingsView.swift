//
//  SettingsView.swift
//  Karmon
//
//  Created by Abdusamad Abdusattorov on 16/12/24.
//

import SwiftUI

struct SettingsView: View {
    
    @State private var selectedCurrency: String = getDefaultCurrency()
    
    let currencies = ["UZS", "USD", "EUR", "GBP", "PLN", "HUF", "KRW"]
    
    var body: some View {
        
        NavigationStack {
            List {
                
                Section {
                    //                    NavigationLink {
                    //                        TransactionsView()
                    //                    } label: {
                    //                        Image(systemName: "creditcard.fill")
                    //                            .foregroundStyle(.white)
                    //                            .frame(width: 32, height: 32)
                    //                            .background(.blue)
                    //                            .cornerRadius(8)
                    //
                    //                        Text("Accounts")
                    //                    }
                    NavigationLink {
                        CategoriesView()
                    } label: {
                        Image(systemName: "bag.fill")
                            .foregroundStyle(.white)
                            .frame(width: 32, height: 32)
                            .background(.blue)
                            .cornerRadius(8)
                        Text("Categories")
                    }
                    
                    
                    HStack {
                        Image(systemName: "dollarsign.circle.fill")
                            .foregroundStyle(.white)
                            .frame(width: 32, height: 32)
                            .background(.blue)
                            .cornerRadius(8)
                        Text("Default Currency")
                        Picker("", selection: $selectedCurrency) {
                            ForEach(currencies, id: \.self) { currency in
                                Text(currency)
                            }
                        }
                        .onChange(of: selectedCurrency) {
                            saveDefaultCurrency(currency: selectedCurrency)
                        }
                        
                    }
                    
                    
                }
                
                //                Section {
                //                    NavigationLink {
                //                        TransactionsView()
                //                    } label: {
                //                        Image(systemName: "square.and.arrow.up.fill")
                //                            .foregroundStyle(.white)
                //                            .frame(width: 32, height: 32)
                //                            .background(.green)
                //                            .cornerRadius(8)
                //                        Text("Export to Excel (.csv)")
                //                    }
                //                }
                //
                //                Section {
                //                    NavigationLink {
                //                        TransactionsView()
                //                    } label: {
                //                        Image(systemName: "envelope.fill")
                //                            .foregroundStyle(.white)
                //                            .frame(width: 32, height: 32)
                //                            .background(.teal)
                //                            .cornerRadius(8)
                //                        Text("Contact Developer")
                //                    }
                //                }
                //
                //                Section(
                //                    footer: Text("Karmon v0.0.1")
                //                        .font(.callout)
                //                        .foregroundStyle(.secondary)
                //                        .frame(maxWidth: .infinity, alignment: .center)
                //                        .padding(.vertical, 8)
                //
                //                ) {
                //                    NavigationLink {
                //                        TransactionsView()
                //                    } label: {
                //                        HStack {
                //                            Image(systemName: "info.circle.fill")
                //                                .foregroundStyle(.white)
                //                                .frame(width: 32, height: 32)
                //                                .background(.blue)
                //                                .cornerRadius(8)
                //                            Text("About")
                //                        }
                //                    }
                //                }
                
            }
            
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

#Preview {
    SettingsView()
        .preferredColorScheme(.dark)
}
