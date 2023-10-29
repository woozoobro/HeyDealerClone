//
//  LicenseTextFieldObject.swift
//  HeyDealerClone
//
//  Created by 우주형 on 2023/10/28.
//

import SwiftUI

struct LicenseTextFieldObject: View {
    @Binding var text: String
    @Binding var blink: Bool
    @Binding var licenseType: LicenseType
    var body: some View {
        HStack(spacing: 0) {
            circle
                .padding(.leading, 12)
            TextFieldLikeView(text: $text, blink: $blink, licenseType: $licenseType)
            circle
                .padding(.trailing, 12)
        }
        .padding(.vertical, 6)
        .background {
            RoundedRectangle(cornerRadius: 10)
                .fill(.shadow(.inner(color: .gray.opacity(0.4), radius: 1, x: 1, y: 1)))
                .foregroundColor(switchBackgroundColor())
                .padding(2)
                .background { RoundedRectangle(cornerRadius: 12).fill(licenseType == .green ? .white : .black) }
                .padding(2)
                .background {
                    RoundedRectangle(cornerRadius: 14)
                        .fill(switchBackgroundColor())
                        .shadow(radius: 0.5)
                }
        }
        .padding(.horizontal, 24)
    }
    
    private var circle: some View {
        Circle()
            .fill(.shadow(.inner(color: switchBackgroundColor().opacity(0.1), radius: 0.5, x: -0.5, y: 1)))
            .foregroundColor(switchCircleColor())
            .shadow(color: .black.opacity(0.4), radius: 0.8, x: 0, y: 1)
            .shadow(color: .black.opacity(0.2), radius: 1, x: 1, y: 0.5)
            .frame(width: 11, height: 11)
    }
}

private extension LicenseTextFieldObject {
    func switchBackgroundColor() -> Color {
        switch licenseType {
            case .normal: return .white
            case .yellow: return .theme.yellowLicense
            case .green: return .theme.greenLicense
        }
    }
    
    func switchCircleColor() -> Color {
        switch licenseType {
            case .normal: return .white
            case .yellow: return .theme.yellowLicense
            case .green: return .theme.greenCircle
        }
    }
}
