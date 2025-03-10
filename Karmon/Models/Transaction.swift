//
//  Transaction.swift
//  Karmon
//
//  Created by Abdusamad Abdusattorov on 09/12/24.
//

import Foundation
import SwiftData

@Model
class Transaction {
    @Attribute(.unique) var id: UUID
    var title: String = ""
    var amount: Double = 0
    var currency: String = ""
    var dateCreated: Date = Date.now
    
    @Relationship
    var category: Category
    
    init(title: String,
         amount: Double,
         currency: String,
         dateCreated: Date = Date.now,
         category: Category) {
        self.id = UUID()
        self.title = title
        self.amount = amount
        self.currency = currency
        self.dateCreated = dateCreated
        self.category = category
    }
    
    init(
        id: UUID,
        title: String,
        amount: Double,
        currency: String,
        dateCreated: Date = Date.now,
        category: Category
    ) {
        self.id = id
        self.title = title
        self.amount = amount
        self.currency = currency
        self.dateCreated = dateCreated
        self.category = category
    }
    
}
