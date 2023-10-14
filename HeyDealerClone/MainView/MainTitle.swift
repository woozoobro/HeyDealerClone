//
//  MainTitle.swift
//  HeyDealerClone
//
//  Created by 우주형 on 2023/10/15.
//

import SwiftUI

struct MainTitle: View {
    let title: String
    let fontColor: Color
    var body: some View {
        Text(title)
            .foregroundColor(fontColor)
            .customFont(fontWeight: .bold, size: 32)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 50)
            .padding(.top, 70)
            .lineSpacing(14)
    }
}
