////
////  StatisticsView.swift
////  Karmon
////
////  Created by Abdusamad Abdusattorov on 19/12/24.
////
//
//import SwiftUI
//import Charts
//
//struct StatisticsView: View {
//    let transactionVM = TransactionViewModel.shared
//    
////    var categorySpendings: [TransactionCategory: Double] {
////        Dictionary(grouping: transactionVM.transactions, by: { $0.category })
////            .mapValues { transactions in
////                transactions.reduce(0) { $0 + $1.amount }
////            }
////    }
//    
//    // Get the total amount spent per category
//    var categorySpendings: [TransactionCategory: Double] {
//        transactionVM.totalSpentPerCategory()
//    }
//    
//    
//    var body: some View {
//        NavigationStack {
//            Spacer()
//            VStack {
//                if categorySpendings.isEmpty {
//                    Text("No data available")
//                        .foregroundStyle(.secondary)
//                        .font(.title2)
//                } else {
//                    Chart {
//                        ForEach(TransactionCategory.allCases, id: \.self) { category in
//                            if let total = categorySpendings[category], total > 0 {
//                                SectorMark(
//                                    angle: .value("Amount", total),
//                                    innerRadius: .ratio(0.6),
//                                    outerRadius: .ratio(1.0),
//                                    angularInset: 1.5
//                                )
//                                .cornerRadius(5)
//                                .foregroundStyle(by: .value("Category", category.rawValue))
//                            }
//                        }
//                    }
//                    .chartLegend(position: .trailing, alignment: .center)
//                    
//    
//                    .chartForegroundStyleScale { (category: String) in
//                        switch category {
//                            case "Groceries": Color.green
//                            case "Eating Out": Color.red
//                            case "Snacks": Color.orange
//                            case "Rent": Color.pink
//                            case "Transport": Color.blue
//                            case "Clothes": Color.purple
//                            case "Traveling": Color.yellow
//                            case "Other": Color.gray
//                            default: Color.gray
//                        }
//                    }
//                    .frame(height: 300)
//
//
//                }
//            }
//            .padding()
//            .navigationTitle("Statistics")
//            .navigationBarTitleDisplayMode(.large)
//            Spacer()
//            Spacer()
//            Spacer()
//            Spacer()
//            Spacer()
//        }
//    }
//}
//
//extension Color {
//    static func random() -> Color {
//        Color(hue: Double.random(in: 0...1), saturation: 0.7, brightness: 0.9)
//    }
//}
//
//#Preview {
//    StatisticsView()
//}
