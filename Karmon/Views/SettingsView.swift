//
//  SettingsView.swift
//  Karmon
//
//  Created by Abdusamad Abdusattorov on 16/12/24.
//

import SwiftUI

struct SettingsView: View {
    
    @State private var selectedCurrency: String = getDefaultCurrency()
    @State private var openRecurringPaymentsView = false
    @State private var openCategoriesView = false
    
    let currencies = getAllCurrencies()
    
    var body: some View {
        
        NavigationStack {
            List {
                
                Section {
                    
//                    Accounts
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
                    
//                    Recurring
//                    Button {
//                        openRecurringPaymentsView.toggle()
//                    } label: {
//                        HStack {
//                            Image(systemName: "clock.arrow.circlepath")
//                                .foregroundStyle(.white)
//                                .frame(width: 32, height: 32)
//                                .background(.blue)
//                                .cornerRadius(8)
//                                .bold()
//                            Text("Recurring")
//                                .foregroundColor(.white)
//                            
//                            Spacer()
//                            Image(systemName: "chevron.right")
//                                .foregroundStyle(Color.secondary)
//                                .imageScale(.small)
//                        }
//                    }
//                    NavigationLink {
//                        RecurringPaymentsView()
//                    } label: {
//                        HStack {
//                            Image(systemName: "clock.arrow.circlepath")
//                                .foregroundStyle(.white)
//                                .frame(width: 32, height: 32)
//                                .background(.blue)
//                                .cornerRadius(8)
//                                .bold()
//                            Text("Recurring")
//                                .foregroundColor(.white)
//                        }
//                    }

                    
//                    Categories
                    NavigationLink {
                        CategoriesView()
                    } label: {
                        HStack {
                            Image(systemName: "folder.fill")
                                .foregroundStyle(.white)
                                .frame(width: 32, height: 32)
                                .background(.blue)
                                .cornerRadius(8)
                                .bold()
                            Text("Categories")
                                .foregroundColor(.white)
                        }
                    }
                    
//                    Default Currency
                    HStack {
                        Image(systemName: "dollarsign.circle.fill")
                            .foregroundStyle(.white)
                            .frame(width: 32, height: 32)
                            .background(.blue)
                            .cornerRadius(8)
                        Text("Default Currency")
//                        Picker("", selection: $selectedCurrency) {
//                            ForEach(currencies, id: \.self) { currency in
//                                Text(currency)
//                            }
//                        }
                        Menu {
                            Picker("", selection: $selectedCurrency) {
                                ForEach(currencies, id: \.self) { currency in
                                    Text(currency)
                                }
                            }
                        } label: {
                            Spacer()
                            HStack {
                                Text(selectedCurrency)
                                    .font(.footnote)
                            }
                            .padding(8)
                            .foregroundStyle(.white)
                            .background(RoundedRectangle(cornerRadius: 8).fill(Color(.tertiarySystemFill)))
                        }
                        .onChange(of: selectedCurrency) {
                            saveDefaultCurrency(currency: selectedCurrency)
                        }
                        
                    }
                }
                
                Section {
                    
////                    Categories
////                    Button {
////                        openCategoriesView.toggle()
////                    } label: {
////                        HStack {
////                            Image(systemName: "folder.fill")
////                                .foregroundStyle(.white)
////                                .frame(width: 32, height: 32)
////                                .background(.blue)
////                                .cornerRadius(8)
////                                .bold()
////                            Text("Categories")
////                                .foregroundColor(.white)
////                            
////                            Spacer()
////                            Image(systemName: "chevron.right")
////                                .foregroundStyle(Color.secondary)
////                                .imageScale(.small)
////                        }
////                    }
//                    NavigationLink {
//                        CategoriesView()
//                    } label: {
//                        HStack {
//                            Image(systemName: "folder.fill")
//                                .foregroundStyle(.white)
//                                .frame(width: 32, height: 32)
//                                .background(.blue)
//                                .cornerRadius(8)
//                                .bold()
//                            Text("Categories")
//                                .foregroundColor(.white)
//                        }
//                    }
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

            .fullScreenCover(isPresented: $openRecurringPaymentsView) {
                RecurringPaymentsView()
            }
            .fullScreenCover(isPresented: $openCategoriesView) {
                CategoriesView()
            }
        }
    }
}

#Preview {
    SettingsView()
        .preferredColorScheme(.dark)
}
