//
//  Category.swift
//  Karmon
//
//  Created by Abdusamad Abdusattorov on 08/03/25.
//

import Foundation
import SwiftData

@Model
class Category {
    @Attribute(.unique) var title: String
//    var dateCreated: Date = Date.now
    
    @Relationship(inverse: \Transaction.category)
    var transactions: [Transaction] = []  // non-optional and default empty
    
    init(
        title: String
//        dateCreated: Date = Date.now
    ) {
        self.title = title
//        self.dateCreated = dateCreated
    }
}
