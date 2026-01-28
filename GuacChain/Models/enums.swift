//
//  enums.swift
//  GuacChain
//
//  Created by app-kaihatsusha on 27/01/2026.
//  Copyright © 2026 app-kaihatsusha. All rights reserved.
//

import Foundation

enum Currency: String, Codable, CaseIterable {
    case usd = "$ USD"
    case gbp = "£ GBP"
    case eur = "€ EUR"
    
    func symbol() -> String {
        switch self {
        case .usd:
            return "$"
        case .gbp:
            return "£"
        case .eur:
            return "€"
        }
    }
}

enum Price: Double, CaseIterable {
    case taco = 5.00
    case burrito = 8.00
    case chips = 3.00
    case horchata = 2.00
}
