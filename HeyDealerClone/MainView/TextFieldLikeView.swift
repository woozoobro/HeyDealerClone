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
    private let numberSize: CGFloat = 48
    private let hangulSize: CGFloat = 38
    
    var body: some View {
        ZStack {
            TextField("", text: $text)
                .allowsHitTesting(false)
                .opacity(0)
            
            ZStack(alignment: .leading) {
                HStack(alignment: .center, spacing: 4) {
                    Text("12")
                        .customFont(fontWeight: .bold, size: numberSize)
                        .minimumScaleFactor(0.4)
                    Text("가")
                        .customFont(fontWeight: .bold, size: hangulSize)
                        .minimumScaleFactor(0.4)
                        .padding(.trailing)
                    Text("3425")
                        .minimumScaleFactor(0.4)
                        .customFont(fontWeight: .bold, size: numberSize)
                }
                .foregroundColor(text.isEmpty ? Color.gray.opacity(0.1) : Color.clear)
                
                LicenseText(text: $text, numberSize: numberSize, hangulSize: hangulSize)
                    .padding(.trailing, text.isEmpty ? 0 : 8)
                    .overlay(alignment: .trailing) {
                        CursorView(blink: $blink)
                            .frame(minHeight: hangulSize)
                            .animation(.easeInOut(duration: 0.2), value: text)
                    }
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.horizontal)
        }
    }
}

struct LicenseText: View {
    @Binding var text: String
    let numberSize: CGFloat
    let hangulSize: CGFloat
    var body: some View {
        HStack(spacing: 0) {
            if text.first?.isNumber == false {
//                VStack {
                    ForEach(Array(text.enumerated()), id: \.offset) { index, element in
                        Text(String(element))
                    }
//                }
            } else {
                ForEach(Array(text.enumerated()), id: \.offset) { index, element in
                    Text(String(element))
                        .customFont(fontWeight: .bold, size: element.isNumber ? numberSize : hangulSize)
                        .padding(.horizontal, element.isLetter ? 4 : 0)
                }
            }
        }
        .frame(minHeight: numberSize)
        .minimumScaleFactor(0.4)
        .foregroundColor(Color.theme.background)
        .foregroundStyle(.shadow(.inner(color: .white.opacity(0.5), radius: 2, x: 0.5, y: 0.5)))
        .shadow(color: .gray.opacity(0.6), radius: 1, x: 0, y: 0)
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
