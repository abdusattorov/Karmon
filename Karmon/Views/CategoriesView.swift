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
    @State private var selectedCategory: Category?
    @FocusState private var titleFocus: Bool
    
    private var isTitleValid: Bool {
        !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    var isEditing: Bool {
        selectedCategory != nil
    }
    
    var body: some View {
        
        NavigationStack {
            
            HStack {
                TextField("New category", text: $title)
                    .textFieldStyle(.roundedBorder)
                    .frame(maxWidth: .infinity)
                    .focused($titleFocus)
                    .onAppear {
                        UITextField.appearance().clearButtonMode = .whileEditing
                    }
                if isEditing {
                    Button("Cancel") {
                        title = ""
                        selectedCategory = nil
                    }
                    .buttonStyle(.bordered)
                }
                Button(isEditing ? "Save" : "Add") {
                    let trimmedTitle = title.trimmingCharacters(in: .whitespacesAndNewlines)
                    guard !trimmedTitle.isEmpty else { return }
                    let newCategory = Category(title: trimmedTitle)
                    context.insert(newCategory)
                    do {
                        try context.save()
                    } catch {
                        print("Failed to save.")
                    }
                    title = ""
                }
                .buttonStyle(.borderedProminent)
                .disabled(!isTitleValid)
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
                            HStack {
                                Text(category.title)
//                                    .opacity(category.title == Constants.otherCategoryName ? 0.5 : 1)
                                if category.title == Constants.otherCategoryName {
                                    Spacer()
                                    Text("default category")
//                                        .italic()
                                        .foregroundStyle(.secondary)
                                        
                                } else {
                                    Spacer()
                                    Button {
                                        
                                    } label: {
                                        Image(systemName: "pencil")
                                            .imageScale(.large)
                                    }
                                }
                            }
                            .contentShape(Rectangle())
                            .onTapGesture {
                                if !(category.title == Constants.otherCategoryName) {
                                    selectedCategory = category
                                    title = category.title
                                }
                            }
                            .deleteDisabled(category.title == Constants.otherCategoryName)
                        }
                        
                        .onDelete { indexSet in
                            for index in indexSet {
                                let categoryToDelete = categories[index]
                                do {
                                    try CategoryDataManager.shared.delete(category: categoryToDelete, in: context)
                                } catch {
                                    // Handle the error here, e.g., show an alert to the user.
                                    print("Error deleting category: \(error.localizedDescription)")
                                }
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
            .onAppear {
                titleFocus = true
            }
        }
        
    }
}

#Preview {
    let preview = Preview(Category.self)
    let category = Category.categorySamples
    
    preview.addExamples(category)
    
    return CategoriesView()
        .modelContainer(preview.container)
}
