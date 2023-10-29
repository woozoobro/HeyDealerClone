//
//  LicenseTextField.swift
//  HeyDealerClone
//
//  Created by 우주형 on 2023/10/15.
//

import SwiftUI

struct LicenseTextField: View {
    @Binding var text: String
    @Binding var licenseType: LicenseType
    @State private var blink: Bool = false
    @FocusState private var focused: Bool
    var body: some View {
        LicenseTextFieldObject(text: $text, blink: $blink, licenseType: $licenseType)
            .focused($focused)
            .onAppear { focused = true }
            .onTapGesture { focused = true }
            .onChange(of: focused) { self.blink = $0 }
            .animation(.easeInOut, value: licenseType)
    }
}
