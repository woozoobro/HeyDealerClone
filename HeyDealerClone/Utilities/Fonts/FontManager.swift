//
//  FontManager.swift
//  HeyDealerClone
//
//  Created by 우주형 on 2023/10/14.
//

import Foundation
import SwiftUI

enum FontWeight: String {
    case black = "Pretendard-Black"
    case bold  = "Pretendard-Bold"
    case exBold = "Pretendard-ExtraBold"
    case exLight = "Pretendard-ExtraLight"
    case light = "Pretendard-Light"
    case medium = "Pretendard-Medium"
    case regular = "Pretendard-Regular"
    case semiBold = "Pretendard-SemiBold"
    case thin = "Pretendard-Thin"
}

struct FontManager: ViewModifier {
    let fontWeight: FontWeight
    let size: CGFloat
    let textStyle: Font.TextStyle
    
    func body(content: Content) -> some View {
        content
            .font(Font.custom(fontWeight.rawValue, size: size, relativeTo: textStyle))
    }
}

extension View {
    func customFont(fontWeight: FontWeight, size: CGFloat, textStyle: Font.TextStyle = .title) -> some View {
        modifier(FontManager(fontWeight: fontWeight, size: size, textStyle: textStyle))
    }
}
