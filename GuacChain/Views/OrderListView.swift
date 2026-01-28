//
//  OrderListView.swift
//  GuacChain
//
//  Created by app-kaihatsusha on 28/01/2026.
//  Copyright © 2026 app-kaihatsusha. All rights reserved.
//

import SwiftUI
import SwiftData

struct OrderListView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query var orders: [Order]
    
    @State private var showOrderSheet = false
    
    var body: some View {
        NavigationStack {
            List(orders) { order in
                NavigationLink {
                    OrderDetailView(order: order)
                } label: {
                    VStack(alignment: .leading) {
                        HStack {
                            Text(order.title)
                            Spacer()
                            Text("\(order.orderedOn.formatted(date: .numeric, time: .omitted))")
                                
                        }
                        .font(.title2)
                        Text(returnQtyLine(order: order))
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }
                .swipeActions {
                    Button("", systemImage: "trash", role: .destructive) {
                        modelContext.delete(order)
                        
                        // for simulator only
                        guard let _ = try? modelContext.save() else {
                            print("😡 ERROR: Delete on OrderListView did not save")
                            return
                        }
                    }
                    
                    
                }
            }
            .listStyle(.plain)
            .navigationTitle("Past Orders:")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("Add", systemImage: "plus") {
                        showOrderSheet.toggle()
                    }
                }
            }
            .sheet(isPresented: $showOrderSheet) {
                NavigationStack {
                    OrderDetailView(order: Order())
                }
            }
        }

    }
    
    func returnQtyLine(order: Order) -> String {
        var orderArray: [String] = []
        
        if order.tacoQty != 0 { orderArray.append("Taco: \(order.tacoQty)")}
        if order.burritoQty != 0 { orderArray.append("Burrito: \(order.burritoQty)")}
        if order.chipsQty != 0 { orderArray.append("Chips: \(order.chipsQty)")}
        if order.horchataQty != 0 { orderArray.append("Horchata: \(order.horchataQty)")}
        
        return orderArray.joined(separator: ", ")
        
    }
}

#Preview {
    OrderListView()
        .modelContainer(Order.preview)
        .environment(CurrencyViewModel())
}
