//
//  Transaction.swift
//  Karmon
//
//  Created by Abdusamad Abdusattorov on 09/12/24.
//

import Foundation
import SwiftData

@Model
class Transaction: Identifiable {
    var id: String
    var title: String
    var amount: Double
    var currency: String
    var timestamp: Date
    
    init(id: String = UUID().uuidString, title: String, amount: Double, currency: String, timestamp: Date) {
        self.id = id
        self.title = title
        self.amount = amount
        self.currency = currency
        self.timestamp = timestamp
    }
}
