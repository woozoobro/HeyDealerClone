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
    private let numberFontSize: CGFloat = 50
    private let hangleFontSize: CGFloat = 38
    
    var body: some View {
        ZStack {
            TextField("", text: $text)
                .allowsHitTesting(false)
                .opacity(0)
            
            HStack(alignment: .center, spacing: 4) {
                Text("12")
                    .customFont(fontWeight: .bold, size: numberFontSize)
                    .minimumScaleFactor(0.4)
                Text("가")
                    .customFont(fontWeight: .bold, size: hangleFontSize)
                    .minimumScaleFactor(0.4)
                    .padding(.trailing)
                Text("3425")
                    .minimumScaleFactor(0.4)
                    .customFont(fontWeight: .bold, size: numberFontSize)
            }
            .foregroundColor(text.isEmpty ? Color.gray.opacity(0.1) : Color.clear)
            .overlay(alignment: .leading) {
                Text(text)
                    .frame(minHeight: numberFontSize)
                    .minimumScaleFactor(0.4)
                    .foregroundColor(Color.theme.background)
                    .customFont(fontWeight: .bold, size: numberFontSize)
                    .foregroundStyle(.shadow(.inner(color: .white.opacity(0.5), radius: 2, x: 0.5, y: 0.5)))
                    .shadow(color: .gray.opacity(0.6), radius: 1, x: 0, y: 0)
                    .padding(.trailing, text.isEmpty ? 0 : 6)
                    .overlay(alignment: .trailing) {
                        CursorView(blink: $blink)
                            .frame(minHeight: hangleFontSize)
                            .animation(.easeInOut(duration: 0.2), value: text)
                    }
            }
        }
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
