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
        HStack {
            Text(transaction.timestamp, format: .dateTime.month(.abbreviated).day())
            Text(transaction.title)
            Spacer()
            Text(transaction.amount, format: .currency(code: "USD"))
        }
    }
}

#Preview {
    TransactionCellView(transaction: Transaction(title: "Groceries", amount: 1, currency: "USD", timestamp: .now))
}
