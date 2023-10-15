//
//  TextFieldLikeView.swift
//  HeyDealerClone
//
//  Created by 우주형 on 2023/10/15.
//

import SwiftUI

struct TextFieldLikeView: View {
    @Binding var text: String
    @Binding var blink: Bool
    private let numberFontSize: CGFloat = 56
    private let hangleFontSize: CGFloat = 40
    private let placeholder: [Character] = Array("12가 3425")
    
    var body: some View {
        ZStack(alignment: .leading) {
            TextField("", text: $text)
                .allowsHitTesting(false)
                .opacity(0)
            if text.isEmpty {
                HStack(alignment: .center, spacing: 0) {
                    ForEach(Array(placeholder.enumerated()), id: \.offset) { index, element in
                        Text(String(element))
                            .customFont(fontWeight: .bold, size: element.isNumber ? numberFontSize : hangleFontSize)
                    }
                }
                .foregroundColor(.secondary)
                .frame(maxWidth: .infinity, alignment: .center)
            }
            
            Text(text)
                .foregroundColor(Color.theme.background)
                .customFont(fontWeight: .bold, size: numberFontSize)
                .foregroundStyle(.shadow(.inner(color: .white.opacity(0.5), radius: 1, x: 0.5, y: 0.5)))
                .shadow(color: .gray.opacity(0.6), radius: 1, x: 0, y: 0)
                .frame(height: numberFontSize)
                .padding(.trailing, text.isEmpty ? 0 : 6)
                .overlay(alignment: .trailing) {
                    CursorView(blink: $blink)
                        .animation(.easeInOut(duration: 0.2), value: text)
                }
        }
//        .minimumScaleFactor(0.5)
    }
}

struct CursorView: View {
    @Binding var blink: Bool
    var body: some View {
        Rectangle()
            .frame(width: 4)
            .foregroundColor(.blue)
            .opacity(blink ? 1 : 0)
            .animation(blink ? .easeInOut(duration: 0.46).repeatForever(autoreverses: true) : .none, value: blink)
            .padding(.vertical, 3)
    }
}
