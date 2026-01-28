//
//  CurrencyViewModel.swift
//  GuacChain
//
//  Created by app-kaihatsusha on 27/01/2026.
//  Copyright © 2026 app-kaihatsusha. All rights reserved.
//

import Foundation

@Observable
class CurrencyViewModel {
    
    struct Response: Codable {
        var bitcoin: Bitcoin
    }
    
    struct Bitcoin: Codable {
        var usd: Double
        var gbp: Double
        var eur: Double
    }
    
    var urlString = "https://api.coingecko.com/api/v3/simple/price?ids=bitcoin&vs_currencies=usd,gbp,eur"
    var usdPerBTC: Double = 0
    var gbpPerBTC: Double = 0
    var eurPerBTC: Double = 0
    
    func getData() async {
        
        print("🕸️ We are accessing the url \(urlString)")
        // Create URL
        guard let url = URL(string: urlString) else {
            print("😡 ERROR: Could not create a URL from \(urlString)")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            // decode JSON into data structure
            guard let response = try? JSONDecoder().decode(Response.self, from: data) else {
                
                print("😡 JSON ERROR: Could not decode returned JSON data")
                return
            }
            
            // Confirm data was decoded:
            print("😎 JSON returned! Dollar Value: \(response.bitcoin.usd)")
            Task { @MainActor in
                print("Pass")
                self.usdPerBTC = response.bitcoin.usd
                self.gbpPerBTC = response.bitcoin.gbp
                self.eurPerBTC = response.bitcoin.eur
                print("usdPerBTC:\(self.usdPerBTC) gbpPerBTC:\(self.gbpPerBTC) eurPerBTC:\(self.eurPerBTC)")
            }
        } catch {
            print("😡 ERROR: Could not get data from \(urlString)")
        }
    }
    
}
