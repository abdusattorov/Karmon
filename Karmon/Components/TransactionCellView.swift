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
            HStack {
                Text(transaction.category.title)
                if transaction.isRecurring {
                    Text("•")
                    Image(systemName: "repeat")
                        .imageScale(.small)
//                    Text(
//                        (transaction.recurranceInterval! > 1) ?
//                        "Every \(transaction.recurranceInterval!) \(transaction.recurranceType!.descr)s" :
//                            "Every \(transaction.recurranceType!.descr)"
//                    )
                    if let recurranceDate = transaction.recurranceDate {
                        Text(recurranceDate.toSectionHeaderFormat())
                    } else {
                        Text("")
                    }
                }
            }
            .font(.caption)
            .foregroundStyle(.gray)
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
        id: UUID(),
        title: "Groceries",
        amount: 1,
        currency: "USD",
        dateCreated: Date.fromString("01-12-2024", format: "dd-MM-yyyy") ?? .now,
        category: mockCategory,
        isRecurring: true,
        recurranceDate: Date.now
    )
    
    TransactionCellView(transaction: mockTransaction)
}
