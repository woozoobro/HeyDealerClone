//
//  SellDestinationView.swift
//  HeyDealerClone
//
//  Created by 우주형 on 2023/10/29.
//

import SwiftUI

struct SellDestinationView: View {
   let license: String
   var body: some View {
      ZStack {
         Color.white.ignoresSafeArea()
         ScrollView {
            VStack(alignment: .leading) {
               NormalLicenseObject {
                  SearchedLicenseText(text: license)
               }
               .scaleEffect(0.5)
            }
            .frame(maxWidth: .infinity)
         }
      }
      .toolbarRole(.editor)
   }
}


struct SearchedLicenseText: View {
   private let numberSize: CGFloat = TEXTFIELD_NUMBER_SIZE
   private let hangulSize: CGFloat = TEXTFIELD_HANGUL_SIZE
   let text: String
   
   var body: some View {
      LazyHGrid(rows: [GridItem(.flexible())], spacing: 0) {
         processNumberFirstNumbers()
         processNumberSecondHangul()
         processNumberSecondNumbers()
      }
      .foregroundColor(.theme.title)
      .foregroundStyle(.shadow(.inner(color: .white.opacity(0.7), radius: 1, x: 0.5, y: 0.5)))
      .shadow(color: .gray.opacity(0.6), radius: 1, x: 0, y: 0)
   }
   
   
   func processTextPart(_ text: String, size: CGFloat) -> some View {
      return Group {
         if !text.isEmpty {
            Text(text)
               .customFont(fontWeight: .bold, size: size)
         } else {
            EmptyView()
         }
      }
   }
   
   func processNumberFirstNumbers() -> some View {
      let firstNumber = String(text.prefix { $0.isNumber })
      return processTextPart(firstNumber, size: numberSize)
         .padding(.leading, firstNumber.count == 3 ? -14 : 0)
   }
   
   func processNumberSecondHangul() -> some View {
      let firstNumbers = text.prefix{ $0.isNumber }
      let hangulAndSecondNumbers = text.dropFirst(firstNumbers.count)
      let hangul = hangulAndSecondNumbers.prefix{ CharacterSet.isJamo($0.unicodeScalars.first!) }
      return processTextPart(String(hangul), size: hangulSize)
   }
   
   func processNumberSecondNumbers() -> some View {
      let firstNumbers = text.prefix{ $0.isNumber }
      let hangulAndSecondNumbers = text.dropFirst(firstNumbers.count)
      let hangul = hangulAndSecondNumbers.prefix{ CharacterSet.isJamo($0.unicodeScalars.first!) }
      let secondNumbers = hangulAndSecondNumbers.dropFirst(hangul.count).filter { $0.isNumber }
      return processTextPart(secondNumbers, size: numberSize)
         .padding(.leading, secondNumbers.isEmpty ? 0 : 14)
   }
}
