//
//  OrderDetailView.swift
//  GuacChain
//
//  Created by app-kaihatsusha on 27/01/2026.
//  Copyright © 2026 app-kaihatsusha. All rights reserved.
//

import SwiftUI

struct OrderDetailView: View {
    
    @State private var tacoQty = 0
    @State private var burritoQty = 0
    @State private var chipsQty = 0
    @State private var horchataQty = 0
    @State private var selectedCurrency: Currency = .usd

    @Environment(CurrencyViewModel.self) private var currencyVM
    
    var body: some View {
        VStack {
            HStack {
                Text("Guac").foregroundStyle(.green)
                Text("Chain").foregroundStyle(.red)
            }
            .font(.custom("Marker Felt", size: 48)).bold()
            .frame(maxWidth: .infinity)
            
            Text("The World's Tasiest Tacos - But We Only Accept Crypto")
                .font(.custom("Papyrus", size: 20))
                .multilineTextAlignment(.center)
            Text("🌮")
                .font(.system(size: 80))
                .multilineTextAlignment(.center)
            
            VStack(alignment: .leading) {
                QuantityView(quantity: $tacoQty, title: "The Satoshi 'Taco' moto")
                QuantityView(quantity: $burritoQty, title: "Bitcoin Burrito")
                QuantityView(quantity: $chipsQty, title: "CryptoChips")
                QuantityView(quantity: $horchataQty, title: "'No Bubble' Horchata")
            }
            
            Spacer()
            
            Picker("", selection: $selectedCurrency) {
                ForEach(Currency.allCases, id: \.self) { Text($0.rawValue) }
            }
            .padding(.horizontal)
            .clipShape(Capsule())
            .pickerStyle(.segmented)
            
            HStack(alignment: .top) {
                Text("Total:")
                    .font(.title)
                VStack(alignment: .leading) {
                    Text("฿ \(calcBitcoin())")
                    Text("\(selectedCurrency.symbol()) \(calcBillInCurrency().formatted(.number.precision(.fractionLength(2))))")
                }
            }
            
            
        }
        .task {
            //await currencyVM.getData()
        }
    }
    
    func calcBillInCurrency() -> Double {
        guard currencyVM.usdPerBTC > 0 else { return calcTotal() }
        
        switch selectedCurrency {
        case .usd:
            return calcTotal()
        case .gbp:
            return calcTotal() / (currencyVM.usdPerBTC / currencyVM.gbpPerBTC)
        case .eur:
            return calcTotal() / (currencyVM.usdPerBTC / currencyVM.eurPerBTC)
        }
    }
    
    private func calcBitcoin() -> String {
        let total = calcTotal()/currencyVM.usdPerBTC
        
        if total > 0 {
            return "\(total.formatted(.number.precision(.fractionLength(6))))"
        } else {
            return "0.000000"
        }
        
    }
    
    private func calcTotal() -> Double {
        
        let tacoCost = Double(tacoQty) * Price.taco.rawValue
        let burritoCost = Double(burritoQty) * Price.taco.rawValue
        let chipsCost = Double(chipsQty) * Price.taco.rawValue
        let horchataCost = Double(horchataQty) * Price.taco.rawValue
        
        return tacoCost+burritoCost+chipsCost+horchataCost
    }
}

#Preview {
    OrderDetailView()
        .environment(CurrencyViewModel())
}
