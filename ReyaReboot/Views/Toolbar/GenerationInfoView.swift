//
//  GenerationInfoView.swift
//  ReyaReboot
//
//  Created by Romaryc Pelissie on 06/06/2025.
//


import SwiftUI

struct GenerationInfoView: View {
    let tokensPerSecond: Double

    var body: some View {
        Text("\(tokensPerSecond, format: .number.precision(.fractionLength(2))) tokens/s")
    }
}

#Preview {
    GenerationInfoView(tokensPerSecond: 58.5834)
}
