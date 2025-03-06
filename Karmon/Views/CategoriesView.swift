//
//  CategoriesView.swift
//  Karmon
//
//  Created by Abdusamad Abdusattorov on 06/03/25.
//

import SwiftUI
import SwiftData

struct CategoriesView: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var context
    @State private var title: String = ""
    @Query private var categories: [Category]
    
    var body: some View {
        
        NavigationStack {
            
            HStack {
                TextField("Category name", text: $title)
                    .textFieldStyle(.roundedBorder)
                    .frame(maxWidth: .infinity)
                
                Button("Add") {
                    let newCategory = Category(title: title)
                    context.insert(newCategory)
                    do {
                        try context.save()
                    } catch {
                        print("Failed to save.")
                    }
                    title = ""
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
            
            Spacer()
            
            Group {
                if categories.isEmpty {
                    ContentUnavailableView {
                        Label("No Categories", systemImage: "bag.fill")
                    } description: {
                        Text("Add Categories to see the list.")
                    }
                } else {
                    List {
                        ForEach(categories) { category in
                            Text(category.title)
                        }
                        
                        .onDelete { indexSet in
                            for index in indexSet {
                                let category = categories[index]
                                context.delete(category)
                            }
                        }
                    }
                    .listStyle(.inset)
                }
            }
            
            
            Spacer()
            
            .navigationTitle("Categories")
//            .navigationBarTitleDisplayMode(.inline)
//            .toolbar {
//                ToolbarItem(placement: .topBarLeading) {
//                    Button("Cancel") {
//                        
//                    }
//                }
//            }
        }
        
    }
}

#Preview {
    CategoriesView()
}
