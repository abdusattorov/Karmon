//
//  TransactionCellView.swift
//  Karmon
//
//  Created by Abdusamad Abdusattorov on 10/12/24.
//

import SwiftUI

struct TransactionCellView: View {
    
    let transaction: Transaction
    
//    func amountFormatted(amount: Double) -> String {
//        let formatter = NumberFormatter()
//        formatter.numberStyle = .currency
//        formatter.usesGroupingSeparator = true
//        formatter.locale = Locale(identifier: "en_US")
//        
//        if let result = formatter.string(from: amount as NSNumber) {
//            return result
//        }
//        
//        return ""
//    }
    
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
