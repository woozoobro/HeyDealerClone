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
   @Namespace var namespace
   private let numberSize: CGFloat = TEXTFIELD_NUMBER_SIZE
   private let hangulSize: CGFloat = TEXTFIELD_HANGUL_SIZE
   var body: some View {
      textFieldLikeView
         .padding(.vertical, 6)
         .background { backgroundLicenseView }
         .padding(.horizontal, licenseType != .green ? 24 : 82)
   }
}

//MARK: - TextField
private extension LicenseTextFieldObject {
   var textFieldLikeView: some View {
      ZStack {
         hiddenTextField
         Group {
            if licenseType != .green {
               notGreenLicense
            } else {
               greenLicense
            }
         }
      }
   }
   
   var backgroundLicenseView: some View {
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
         .matchedGeometryEffect(id: "licenseBack", in: namespace)
   }
}

//MARK: - Componenet
private extension LicenseTextFieldObject {
   var circle: some View {
      Circle()
         .fill(.shadow(.inner(color: switchBackgroundColor().opacity(0.1), radius: 0.5, x: -0.5, y: 1)))
         .foregroundColor(switchCircleColor())
         .shadow(color: .black.opacity(0.4), radius: 0.8, x: 0, y: 1)
         .shadow(color: .black.opacity(0.2), radius: 1, x: 1, y: 0.5)
         .frame(width: 11, height: 11)
   }
   
   var hiddenTextField: some View {
      TextField("", text: $text)
         .allowsHitTesting(false)
         .opacity(0)
   }
   
   var notGreenLicense: some View {
      HStack(spacing: 0) {
         circle
            .matchedGeometryEffect(id: "circle1", in: namespace)
         Spacer()
         HStack(alignment: .center, spacing: 0) {
            Text("12")
               .customFont(fontWeight: .bold, size: numberSize)
            Text("가")
               .customFont(fontWeight: .bold, size: hangulSize)
            Text("3425")
               .customFont(fontWeight: .bold, size: numberSize)
               .padding(.leading)
         }
         .foregroundColor(text.isEmpty ? Color.gray.opacity(0.1) : Color.clear)
         .overlay(alignment: .leading) {
            Group {
               if let firstText = text.first, firstText.isNumber {
                  LazyHGrid(rows: [GridItem(.flexible())], spacing: 0) {
                     processNumberFirstNumbers()
                     processNumberSecondHangul()
                     processNumberSecondNumbers()
                  }
               } else {
                  LazyHGrid(rows: [GridItem(.flexible())], spacing: 0) {
                     processHangulFirstHanguls()
                     processHangulFirstNumbers()
                     processHangulSecondHangul()
                        .matchedGeometryEffect(id: "secondHangul", in: namespace)
                     processHangulSecondNumbers()
                  }
                  .padding(.leading, -20)
               }
            }
            .frame(minHeight: hangulSize, idealHeight: hangulSize)
            .overlay(alignment: .trailing) {
               CurosrView(text: $text, blink: $blink, licenseType: $licenseType)
                  .matchedGeometryEffect(id: "cursor", in: namespace)
            }
         }
         Spacer()
         circle
            .matchedGeometryEffect(id: "circle2", in: namespace)
      }
      .padding(.horizontal, 12)
      .matchedGeometryEffect(id: "license", in: namespace)
   }
   
   var greenLicense: some View {
      LazyVGrid(columns: [GridItem(.flexible())], spacing: 14) {
         HStack(spacing: 10) {
            circle
               .matchedGeometryEffect(id: "circle1", in: namespace)
            processHangulGreenFirstLetters()
            circle
               .matchedGeometryEffect(id: "circle2", in: namespace)
         }
         HStack {
            HStack {
               processHangulSecondHangul()
                  .matchedGeometryEffect(id: "secondHangul", in: namespace)
               processHangulSecondNumbers()
            }
            .overlay(alignment: .trailing) {
               CurosrView(text: $text, blink: $blink, licenseType: $licenseType)
                  .matchedGeometryEffect(id: "cursor", in: namespace)
            }
            Spacer()
         }
         .padding(.leading, 24)
         .frame(idealHeight: numberSize)
      }
      .matchedGeometryEffect(id: "license", in: namespace)
   }
}

//MARK: - Split Text
private extension LicenseTextFieldObject {
   func processTextPart(_ text: String, size: CGFloat) -> some View {
      return Group {
         if !text.isEmpty {
            Text(text)
               .customFont(fontWeight: .bold, size: size)
               .foregroundColor(switchTitleColor())
         } else {
            EmptyView()
         }
      }
   }
   
   //MARK: - Begin Number Case
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
   
   //MARK: - Begin Hangul Case
   func processHangulFirstHanguls() -> some View {
      let firstHangul = String(text.prefix { CharacterSet.isJamo($0.unicodeScalars.first!) })
      return Group {
         if firstHangul.isEmpty {
            EmptyView()
         } else {
            VStack {
               ForEach(Array(firstHangul.enumerated()), id: \.offset) { (index, hangul) in
                  Text(String(hangul))
                     .customFont(fontWeight: .bold, size: TEXTFIELD_SMALL_HANGUL_SIZE)
                     .foregroundColor(switchTitleColor())
               }
            }
         }
      }
   }
   
   func processHangulFirstNumbers() -> some View {
      let firstHangul = String(text.prefix { CharacterSet.isJamo($0.unicodeScalars.first!) })
      let numbersAndRest = text.dropFirst(firstHangul.count)
      let firstNumbers = String(numbersAndRest.prefix { $0.isNumber })
      return processTextPart(firstNumbers, size: numberSize)
         .padding(.leading, 5)
   }
   
   func processHangulSecondHangul() -> some View {
      let firstHangul = String(text.prefix { CharacterSet.isJamo($0.unicodeScalars.first!) })
      let numbersAndRest = text.dropFirst(firstHangul.count)
      let hangul = String(numbersAndRest.filter { CharacterSet.isJamo($0.unicodeScalars.first!) })
      return processTextPart(hangul, size: hangulSize)
   }
   
   func processHangulSecondNumbers() -> some View {
      let firstHangul = String(text.prefix { CharacterSet.isJamo($0.unicodeScalars.first!) })
      let numbersAndRest = text.dropFirst(firstHangul.count)
      let firstNumbers = numbersAndRest.prefix {$0.isNumber}
      let hangulAndSecondNumbers = numbersAndRest.dropFirst(firstNumbers.count)
      let hangul = hangulAndSecondNumbers.prefix { CharacterSet.isJamo($0.unicodeScalars.first!)}
      let secondNumbers = String(hangulAndSecondNumbers.dropFirst(hangul.count).filter { $0.isNumber })
      return processTextPart(secondNumbers, size: numberSize)
         .padding(.leading, secondNumbers.isEmpty ? 0 : 7)
   }
   
   func processHangulGreenFirstLetters() -> some View {
      let firstHangul = String(text.prefix { CharacterSet.isJamo($0.unicodeScalars.first!)})
      let numbersAndRest = text.dropFirst(firstHangul.count)
      let firstNumbers = String(numbersAndRest.prefix { $0.isNumber} )
      
      return HStack {
         processTextPart(firstHangul, size: TEXTFIELD_SMALL_HANGUL_SIZE)
         processTextPart(firstNumbers, size: TEXTFIELD_SMALL_HANGUL_SIZE)
      }
   }
}

//MARK: - Colors
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
   
   func switchTitleColor() -> Color {
      switch licenseType {
         case .normal: return .theme.blackLicenseText
         case .yellow: return .theme.blackLicenseText
         case .green: return .white
      }
   }
}

//MARK: - Cursor
struct CurosrView: View {
   @Binding var text: String
   @Binding var blink: Bool
   @Binding var licenseType: LicenseType
   var body: some View {
      Rectangle()
         .foregroundColor(licenseType == .green ? .white : .blue)
         .frame(width: 4)
         .offset(x: text.isEmpty ? 0 : 8)
         .animation(.easeInOut(duration: 0.2), value: text)
         .opacity(blink ? 1 : 0)
         .padding(.vertical, 6)
         .animation(blink ? .easeInOut(duration: 0.46).repeatForever(autoreverses: true) : .none, value: blink)
         .onChange(of: licenseType) { _ in
            Task {
               blink.toggle()
               try? await Task.sleep(for: .seconds(0.5))
               blink.toggle()
            }
         }
   }
}
