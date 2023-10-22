//
//  LicenseTextField.swift
//  HeyDealerClone
//
//  Created by 우주형 on 2023/10/15.
//

import SwiftUI

struct LicenseTextField: View {
    @Binding var text: String
    @State private var blink: Bool = false
    @FocusState private var focused: Bool
    var body: some View {
        LicenseObject {
            TextFieldLikeView(text: $text, blink: $blink)
                .focused($focused)
                .onAppear { focused = true }
                .onTapGesture { focused = true }
                .onChange(of: focused) { self.blink = $0 }
        }
    }
}
