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
    @Binding var licenseType: LicenseType
    private let numberSize: CGFloat = TEXTFIELD_NUMBER_SIZE
    private let hangulSize: CGFloat = TEXTFIELD_HANGUL_SIZE
    
    var body: some View {
        ZStack {
            hiddenTextField
                        
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
                            processHangulSecondNumbers()
                        }
                        .padding(.leading, -14)
                    }
                }
                .frame(minHeight: hangulSize, idealHeight: hangulSize)
                .overlay(alignment: .trailing) {
                    cursor
                        .animation(.easeInOut(duration: 0.2), value: text)
                        .offset(x: text.isEmpty ? 0 : 8)
                }
            }
        }
    }
}

//MARK: - Component
private extension TextFieldLikeView {
    var cursor: some View {
        Rectangle()
            .frame(width: 4)
            .foregroundColor(licenseType == .green ? .white : .blue)
            .opacity(blink ? 1 : 0)
            .animation(blink ? .easeInOut(duration: 0.46).repeatForever(autoreverses: true) : .none, value: blink)
            .padding(.vertical, 6)
    }
    
    var hiddenTextField: some View {
        TextField("", text: $text)
            .allowsHitTesting(false)
            .opacity(0)
    }
}

//MARK: - Colors
private extension TextFieldLikeView {
    func switchTitleColor() -> Color {
        switch licenseType {
            case .normal: return .theme.blackLicenseText
            case .yellow: return .theme.blackLicenseText
            case .green: return .white
        }
    }
}

//MARK: - Split Text
private extension TextFieldLikeView {
    func processNumberFirstNumbers() -> some View {
        let firstNumber = String(text.prefix { $0.isNumber })
        return Group {
            if firstNumber.isEmpty {
                EmptyView()
            } else {
                Text(firstNumber)
                    .frame(minHeight:  numberSize)
                    .customFont(fontWeight: .bold, size: numberSize)
                    .foregroundColor(switchTitleColor())
                    .padding(.leading, firstNumber.count == 3 ? -14 : 0)
            }
        }
    }
    func processNumberSecondHangul() -> some View {
        let firstNumbers = text.prefix{ $0.isNumber }
        let hangulAndSecondNumbers = text.dropFirst(firstNumbers.count)
        let hangul = hangulAndSecondNumbers.prefix{ CharacterSet.isJamo($0.unicodeScalars.first!) }
                
        return Group {
            if hangul.isEmpty {
                EmptyView()
            } else {
                Text(String(hangul))
                    .customFont(fontWeight: .bold, size: hangulSize)
                    .foregroundColor(switchTitleColor())
            }
        }
    }
    func processNumberSecondNumbers() -> some View {
        let firstNumbers = text.prefix{ $0.isNumber }
        let hangulAndSecondNumbers = text.dropFirst(firstNumbers.count)
        let hangul = hangulAndSecondNumbers.prefix{ CharacterSet.isJamo($0.unicodeScalars.first!) }
        let secondNumbers = hangulAndSecondNumbers.dropFirst(hangul.count).filter { $0.isNumber }
                
        return Group {
            if secondNumbers.isEmpty {
                EmptyView()
            } else {
                Text(String(secondNumbers))
                    .customFont(fontWeight: .bold, size: numberSize)
                    .foregroundColor(switchTitleColor())
                    .padding(.leading, secondNumbers.isEmpty ? 0 : 14)
            }
        }
    }
    
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
        
        return Group {
            if numbersAndRest.isEmpty {
                EmptyView()
            } else {
                Text(String(numbersAndRest.prefix { $0.isNumber }))
                    .frame(minHeight:  numberSize)
                    .customFont(fontWeight: .bold, size: numberSize)
                    .foregroundColor(switchTitleColor())
                    .padding(.leading, 5)
            }
        }
    }
    
    func processHangulSecondHangul() -> some View {
        let firstHangul = String(text.prefix { CharacterSet.isJamo($0.unicodeScalars.first!) })
        let numbersAndRest = text.dropFirst(firstHangul.count)
        let hangul = numbersAndRest.filter { CharacterSet.isJamo($0.unicodeScalars.first!) }
        
        return Group {
            if hangul.isEmpty {
                EmptyView()
            } else {
                Text(String(hangul))
                    .customFont(fontWeight: .bold, size: hangulSize)
                    .foregroundColor(switchTitleColor())
            }
        }
    }
    
    func processHangulSecondNumbers() -> some View {
        let firstHangul = String(text.prefix { CharacterSet.isJamo($0.unicodeScalars.first!) })
        let numbersAndRest = text.dropFirst(firstHangul.count)
        let firstNumbers = numbersAndRest.prefix {$0.isNumber}
        let hangulAndSecondNumbers = numbersAndRest.dropFirst(firstNumbers.count)
        let hangul = hangulAndSecondNumbers.prefix { CharacterSet.isJamo($0.unicodeScalars.first!)}
        let secondNumbers = hangulAndSecondNumbers.dropFirst(hangul.count).filter { $0.isNumber }
        
        return Group {
            if secondNumbers.isEmpty {
                EmptyView()
            } else {
                Text(String(secondNumbers))
                    .customFont(fontWeight: .bold, size: numberSize)
                    .foregroundColor(switchTitleColor())
            }
        }
    }
    
}
