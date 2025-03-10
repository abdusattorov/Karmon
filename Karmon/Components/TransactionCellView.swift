//
//  TransactionCellView.swift
//  Karmon
//
//  Created by Abdusamad Abdusattorov on 10/12/24.
//

import SwiftUI

struct TransactionCellView: View {
    
    let transaction: Transaction
//    let category: Category
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(transaction.title)
                Spacer()
                Text(transaction.amount, format: .currency(code: transaction.currency))
            }
            Text(transaction.category.title)
                .foregroundStyle(.gray)
                .font(.caption)
        }
    }
}

#Preview {
    let mockCategory = Category(title: "other")
    let mockTransaction = Transaction(
        title: "Groceries",
        amount: 1,
        currency: "USD",
        dateCreated: Date.fromString("01-12-2024", format: "dd-MM-yyyy") ?? .now,
        category: mockCategory
    )
    
    TransactionCellView(transaction: mockTransaction)
}
