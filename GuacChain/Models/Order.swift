//
//  Order.swift
//  GuacChain
//
//  Created by app-kaihatsusha on 28/01/2026.
//  Copyright © 2026 app-kaihatsusha. All rights reserved.
//

import Foundation
import SwiftData

@Model
class Order {
    var title: String
    var tacoQty: Int
    var burritoQty: Int
    var chipsQty: Int
    var horchataQty: Int
    var currencySelection: Currency
    var orderedOn = Date()
    
    init(title: String, tacoQty: Int, burritoQty: Int, chipsQty: Int, horchataQty: Int, currencySelection: Currency, orderedOn: Date = Date()) {
        self.title = title
        self.tacoQty = tacoQty
        self.burritoQty = burritoQty
        self.chipsQty = chipsQty
        self.horchataQty = horchataQty
        self.currencySelection = currencySelection
        self.orderedOn = orderedOn
    }
    
    convenience init() {
        self.init(title: "", tacoQty: 0, burritoQty: 0, chipsQty: 0, horchataQty: 0, currencySelection: .usd)
    }
}

extension Order {
    
    @MainActor
    static var preview: ModelContainer {
        let modelContainer = try! ModelContainer(for: Order.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        
        modelContainer.mainContext.insert(Order(title: "Lunch Order", tacoQty: 3, burritoQty: 0, chipsQty: 0, horchataQty: 1, currencySelection: .usd))
        modelContainer.mainContext.insert(Order(title: "Date Night", tacoQty: 3, burritoQty: 1, chipsQty: 1, horchataQty: 2, currencySelection: .usd))
        modelContainer.mainContext.insert(Order(title: "Vacation in UK", tacoQty: 0, burritoQty: 1, chipsQty: 1, horchataQty: 1, currencySelection: .gbp))
        modelContainer.mainContext.insert(Order(title: "Dinner Order", tacoQty: 1, burritoQty: 1, chipsQty: 1, horchataQty: 1, currencySelection: .usd))
        
        return modelContainer
    }
}
