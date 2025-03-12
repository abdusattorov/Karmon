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
                Text(formattedAmount(transaction.amount, currencyCode: transaction.currency))
            }
            Text(transaction.category.title)
                .foregroundStyle(.gray)
                .font(.caption)
        }
    }
    
    private func currencyFormatter(for currencyCode: String) -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = currencyCode
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        return formatter
    }

    private func formattedAmount(_ amount: Double, currencyCode: String) -> String {
        let formatter = currencyFormatter(for: currencyCode)
        return formatter.string(from: NSNumber(value: amount)) ?? "$0"
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
