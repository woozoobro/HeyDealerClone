//
//  LicenseTextField.swift
//  HeyDealerClone
//
//  Created by 우주형 on 2023/10/15.
//

import SwiftUI

struct LicenseTextField: View {
    @State private var text: String = ""
    
    var body: some View {
        LicenseObject {
            TextField("12가 3425", text: $text)
                .foregroundColor(.theme.background)
                .autocorrectionDisabled()
                .minimumScaleFactor(0.5)
                .foregroundStyle(.shadow(.inner(color: .white.opacity(0.5), radius: 1, x: 0.5, y: 0.5)))
                .customFont(fontWeight: .semiBold, size: 50)
                .shadow(color: .gray.opacity(0.6), radius: 1, x: 0, y: 0)
                .padding(.horizontal)
        }
    }
}
