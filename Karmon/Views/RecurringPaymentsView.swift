//
//  RecurringPaymentsView.swift
//  Karmon
//
//  Created by Abdusamad Abdusattorov on 15/03/25.
//

import SwiftUI

struct RecurringPaymentsView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            
            List {
                VStack(alignment: .leading) {
                    Text("Eating out")
                        .foregroundStyle(.gray)
                        .font(.caption)
                    HStack {
                        Text("Breakfast with Otabek")
                        Spacer()
                        Text(formattedAmount(1000, currencyCode: "USD"))
                    }
                    HStack {
                        Image(systemName: "repeat")
                        Text(Date.distantFuture.toSectionHeaderFormat())
                            .font(.caption2)
                    }
                    .foregroundColor(.gray)
                }
                VStack(alignment: .leading) {
                    Text("Eating out")
                        .foregroundStyle(.gray)
                        .font(.caption)
                    HStack {
                        Text("Breakfast with Otabek")
                        Spacer()
                        Text(formattedAmount(1000, currencyCode: "USD"))
                    }
                    HStack {
                        Image(systemName: "repeat")
                        Text(Date.distantFuture.toSectionHeaderFormat())
                            .font(.caption2)
                    }
                    .foregroundColor(.gray)
                }
                
            }
            
            .navigationTitle("Recurring")
            .navigationBarTitleDisplayMode(.large)
//            .toolbar {
//                ToolbarItem(placement: .navigationBarLeading) {
//                    Button("Done") {
//                        dismiss()
//                    }
//                }
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    Button("Add", systemImage: "plus") {
//                        
//                    }
//                }
//            }
        }
    }
}

#Preview {
    RecurringPaymentsView()
}
