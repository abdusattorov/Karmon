//
//  Transaction.swift
//  Karmon
//
//  Created by Abdusamad Abdusattorov on 09/12/24.
//

import Foundation
import SwiftData

enum RecurranceType: Int, Identifiable, Codable, CaseIterable {
    case daily, weekly, monthly, yearly
    
    var id: Self {
        self
    }
     
    var descr: LocalizedStringResource {
        switch self {
        case .daily:
            "Day"
        case .weekly:
            "Week"
        case .monthly:
            "Month"
        case .yearly:
            "Year"
        }
    }
}

@Model
class Transaction {
    @Attribute(.unique) var id: UUID
    var title: String = ""
    var amount: Double = 0
    var currency: String = ""
    var dateCreated: Date = Date.now
    
    var isRecurring: Bool = false
    var recurranceType: RecurranceType?
    var recurranceInterval: Int?
    var recurranceDate: Date?
    
    @Relationship
    var category: Category
    
    init(title: String,
         amount: Double,
         currency: String,
         dateCreated: Date = Date.now,
         category: Category
    ) {
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
    
    init(
        id: UUID,
        title: String,
        amount: Double,
        currency: String,
        dateCreated: Date = Date.now,
        category: Category,
        isRecurring: Bool,
        recurranceType: RecurranceType? = RecurranceType.monthly,
        recurranceInterval: Int? = 1,
        recurranceDate: Date?
    ) {
        self.id = id
        self.title = title
        self.amount = amount
        self.currency = currency
        self.dateCreated = dateCreated
        self.category = category
        self.isRecurring = isRecurring
        self.recurranceType = recurranceType
        self.recurranceInterval = recurranceInterval
        self.recurranceDate = recurranceDate
    }
}
