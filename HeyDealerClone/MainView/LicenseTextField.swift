//
//  LicenseTextField.swift
//  HeyDealerClone
//
//  Created by 우주형 on 2023/10/15.
//

import SwiftUI

struct LicenseTextField: View {
    @Binding var text: String
    @Binding var blink: Bool
    
    var body: some View {
        LicenseObject {
            TextFieldLikeView(text: $text, blink: $blink)
//                .toolbarBackground(.hidden, for: .automatic)
//                .toolbar(.hidden, for: .automatic)
//                .autocorrectionDisabled()
//                .foregroundColor(.theme.background)
//                .minimumScaleFactor(0.5)
//                .foregroundStyle(.shadow(.inner(color: .white.opacity(0.5), radius: 1, x: 0.5, y: 0.5)))
//                .shadow(color: .gray.opacity(0.6), radius: 1, x: 0, y: 0)
//                .customFont(fontWeight: .semiBold, size: 50)
//                .padding(.horizontal)
        }
    }
}
