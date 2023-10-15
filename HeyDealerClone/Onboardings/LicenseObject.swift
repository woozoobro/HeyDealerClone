//
//  LicenseObject.swift
//  HeyDealerClone
//
//  Created by 우주형 on 2023/10/15.
//

import SwiftUI

struct LicenseObject<Content: View>: View {
    @ViewBuilder var content: Content
    var body: some View {
        HStack {
            circle
            content
                .padding(.horizontal)
            circle
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .padding(.horizontal, 20)
        .frame(height: 80)
        .padding(.vertical, 5)
        .background {
            RoundedRectangle(cornerRadius: 10)
                .fill(.shadow(.inner(color: .gray.opacity(0.4), radius: 1, x: 1, y: 1)))
                .foregroundColor(.white)
                .padding(3)
                .background { RoundedRectangle(cornerRadius: 12).fill(.black) }
                .padding(3)
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
            .shadow(color: .gray.opacity(0.4), radius: 0.8, x: 0, y: 1)
            .shadow(color: .gray.opacity(0.2), radius: 1, x: 1, y: 0.5)
            .foregroundColor(.white)
            .frame(width: 12)
    }
}

struct MockLicenseText: View {
    let title: String
    var body: some View {
        Text(title)
            .minimumScaleFactor(0.5)
            .foregroundStyle(.shadow(.inner(color: .white.opacity(0.5), radius: 1, x: 0.5, y: 0.5)))
            .customFont(fontWeight: .semiBold, size: 50)
            .shadow(color: .gray.opacity(0.6), radius: 1, x: 0, y: 0)
    }
}
