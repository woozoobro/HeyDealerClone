//
//  LicenseObject.swift
//  HeyDealerClone
//
//  Created by 우주형 on 2023/10/15.
//

import SwiftUI

struct NormalLicenseObject<Content: View>: View {
    @ViewBuilder var content: Content
    var body: some View {
        HStack(spacing: 0) {
            circle
                .padding(.leading, 12)
            content
                .frame(maxWidth: .infinity)
            circle
                .padding(.trailing, 12)
        }
        .padding(.vertical, 6)
        .background {
            RoundedRectangle(cornerRadius: 10)
                .fill(.shadow(.inner(color: .gray.opacity(0.4), radius: 1, x: 1, y: 1)))
                .foregroundColor(.white)
                .padding(2)
                .background { RoundedRectangle(cornerRadius: 12).fill(.black) }
                .padding(2)
                .background {
                    RoundedRectangle(cornerRadius: 14)
                        .fill(.white)
                        .shadow(radius: 0.5)
                }
        }
        .padding(.horizontal, 24)
    }
    
    private var circle: some View {
        Circle()
            .fill(.shadow(.inner(color: .white.opacity(0.1), radius: 0.5, x: -0.5, y: 1)))
            .foregroundColor(.white)
            .shadow(color: .black.opacity(0.4), radius: 0.8, x: 0, y: 1)
            .shadow(color: .black.opacity(0.2), radius: 1, x: 1, y: 0.5)
            .frame(width: 11, height: 11)
    }
}


struct MockLicenseText: View {
    private let numberFontSize: CGFloat = TEXTFIELD_NUMBER_SIZE
    private let hangulFontSize: CGFloat = TEXTFIELD_HANGUL_SIZE
    
    var body: some View {
        HStack(alignment: .center, spacing: 4) {
            Text("12")
                .customFont(fontWeight: .bold, size: numberFontSize)
            Text("가")
                .customFont(fontWeight: .bold, size: hangulFontSize)
                .padding(.trailing)
            Text("3425")
                .customFont(fontWeight: .bold, size: numberFontSize)
        }
        .minimumScaleFactor(0.3)
        .foregroundStyle(.shadow(.inner(color: .white.opacity(0.7), radius: 1, x: 0.5, y: 0.5)))
        .shadow(color: .gray.opacity(0.6), radius: 1, x: 0, y: 0)
    }
}

struct MockLicenseText2: View {
    let title: String
    private let numberFontSize: CGFloat = TEXTFIELD_NUMBER_SIZE
    
    var body: some View {
        
        Text(title)
            .multilineTextAlignment(.center)
            .customFont(fontWeight: .bold, size: numberFontSize)
            .minimumScaleFactor(0.3)
            .foregroundStyle(.shadow(.inner(color: .white.opacity(0.7), radius: 1, x: 0.5, y: 0.5)))
            .shadow(color: .gray.opacity(0.6), radius: 1, x: 0, y: 0)
    }
}

