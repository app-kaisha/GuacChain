//
//  GuacChainApp.swift
//  GuacChain
//
//  Created by app-kaihatsusha on 27/01/2026.
//  Copyright © 2026 app-kaihatsusha. All rights reserved.
//

import SwiftUI
import SwiftData

@main
struct GuacChainApp: App {
    
    @State private var currencyVM = CurrencyViewModel()
    
    var body: some Scene {
        WindowGroup {
            OrderListView()
                .environment(currencyVM)
                .modelContainer(for: Order.self)
                .onAppear {
                    Thread.sleep(forTimeInterval: 3)
                }
        }
    }
    
    init() {
        print(URL.applicationSupportDirectory.path(percentEncoded: false))
    }
}
