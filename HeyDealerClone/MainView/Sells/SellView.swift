//
//  SellView.swift
//  HeyDealerClone
//
//  Created by 우주형 on 2023/10/15.
//

import SwiftUI

final class SellViewModel: ObservableObject {
    @Published var blink: Bool = false
    @Published var text: String = ""
    
    func updateText(newValue: String) {
        text = CharacterSet.filterHangulAndNumbers(from: newValue)
    }
}

struct SellView: View {
    @EnvironmentObject private var sellVM: SellViewModel
    var body: some View {
        VStack(spacing: 50) {
            MainTitle(title: "먼저, 내 차 시세를\n알아볼까요?", fontColor: .theme.background)
            
            LicenseTextField(text: $sellVM.text, blink: $sellVM.blink)
                .onTapGesture { sellVM.blink = true }
                .onChange(of: sellVM.text) { newValue in
                    sellVM.updateText(newValue: newValue)
                }
            
            Spacer()
        }
    }
}
