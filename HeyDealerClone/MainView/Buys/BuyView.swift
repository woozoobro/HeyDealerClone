//
//  BuyView.swift
//  HeyDealerClone
//
//  Created by 우주형 on 2023/10/15.
//

import SwiftUI

struct BuyView: View {
    @FocusState private var focused: Bool
    var body: some View {
        VStack(spacing: 50) {
            MainTitle(title: "구매할 중고차,\n숨은 이력 찾기", fontColor: .white)
            
            LicenseTextField()
                .focused($focused)
                .onAppear {
                    focused = true
                }
            
            Spacer()
        }
        .background(Color.theme.background)        
    }
}
