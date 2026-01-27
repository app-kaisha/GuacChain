//
//  QuantityView.swift
//  GuacChain
//
//  Created by app-kaihatsusha on 27/01/2026.
//  Copyright © 2026 app-kaihatsusha. All rights reserved.
//

import SwiftUI

struct QuantityView: View {
    
    @Binding var quantity: Int
    @State var title: String
    
    var body: some View {
        HStack(alignment: .top) {
            Text("\(quantity)")
                .font(.system(size: 48))
                .fontWeight(.heavy)
                .frame(width: 70)
            
            VStack(alignment: .leading) {
                Text(title)
                    .font(.title2)
                Stepper("", value: $quantity, in: 0...9)
                    .labelsHidden()
                    .clipShape(Capsule())
            }
        }
    }
}

#Preview {
    @Previewable @State var pQuantity = 0
    QuantityView(quantity: $pQuantity, title: "The Satoshi 'Taco' moto")
}
