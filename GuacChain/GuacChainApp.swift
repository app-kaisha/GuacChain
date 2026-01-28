//
//  GuacChainApp.swift
//  GuacChain
//
//  Created by app-kaihatsusha on 27/01/2026.
//  Copyright © 2026 app-kaihatsusha. All rights reserved.
//

import SwiftUI

@main
struct GuacChainApp: App {
    
    @State private var currencyVM = CurrencyViewModel()
    
    var body: some Scene {
        WindowGroup {
            OrderDetailView()
                .environment(currencyVM)
                .onAppear {
                    Thread.sleep(forTimeInterval: 3)
                }
        }
    }
}
