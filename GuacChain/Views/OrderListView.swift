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
                    Text(order.title)
                        .font(.title2)
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
}

#Preview {
    OrderListView()
        .modelContainer(Order.preview)
        .environment(CurrencyViewModel())
}
