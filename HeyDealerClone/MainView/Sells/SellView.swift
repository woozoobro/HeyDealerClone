//
//  SellView.swift
//  HeyDealerClone
//
//  Created by 우주형 on 2023/10/15.
//

import SwiftUI

struct SellView: View {
    var body: some View {
        VStack(spacing: 50) {
            MainTitle(title: "먼저, 내 차 시세를\n알아볼까요?", fontColor: .theme.background)
            
            LicenseTextField()
            
            Spacer()
        }
        .background(.white)        
    }
}
