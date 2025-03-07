//
//  TransactionCellView.swift
//  Karmon
//
//  Created by Abdusamad Abdusattorov on 10/12/24.
//

import SwiftUI

struct TransactionCellView: View {
    
    let transaction: Transaction
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(transaction.title)
                Spacer()
                Text(transaction.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
            }
            Text("Category here")
                .foregroundStyle(.gray)
                .font(.caption)
        }
    }
}

#Preview {
    TransactionCellView(transaction: Transaction(title: "Groceries", amount: 1, currency: "USD", dateCreated: .now))
}
