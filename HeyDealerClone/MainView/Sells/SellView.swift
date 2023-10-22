//
//  SellView.swift
//  HeyDealerClone
//
//  Created by 우주형 on 2023/10/15.
//

import SwiftUI

final class SellViewModel: ObservableObject {
    @Published var blink: Bool = false
    @Published var text: String = ""
    
    func updateText(newValue: String) {
        var filteredValue = CharacterSet.filterHangulAndNumbers(from: newValue)
        
        if let firstCharacter = filteredValue.first, firstCharacter.isNumber {
            let firstNumbers = filteredValue.prefix{ $0.isNumber }
            if firstNumbers.count > 3 {
                filteredValue = String(firstNumbers.prefix(3)) + filteredValue.dropFirst(firstNumbers.count)
            }
            
            if let firstNumberIndex = filteredValue.firstIndex(where: { $0.isNumber }) {
                let secondNumbers = filteredValue[firstNumberIndex...].filter { $0.isNumber }
                if secondNumbers.count > 7 {
                    let excessNumbersCount = secondNumbers.count - 7
                    filteredValue = String(filteredValue.dropLast(excessNumbersCount))
                }
            }
            
            let hangulCharacters = filteredValue.filter { CharacterSet.isJamo($0.unicodeScalars.first!) }
            if hangulCharacters.count > 1 {
                filteredValue = filteredValue.replacingOccurrences(of: String(hangulCharacters), with: String(hangulCharacters.first!))
            }
        }
        
        text = filteredValue
    }
}

extension String {
    var isHangul: Bool {
        unicodeScalars.contains { CharacterSet.modernHangul.contains($0) }
    }
}

struct SellView: View {
    @EnvironmentObject private var sellVM: SellViewModel
    var body: some View {
        VStack(spacing: 40) {
            MainTitle(title: "먼저, 내 차 시세를\n알아볼까요?", fontColor: .theme.background)
            
            LicenseTextField(text: $sellVM.text, blink: $sellVM.blink)
                .onTapGesture { sellVM.blink = true }
                .onChange(of: sellVM.text) { newValue in
                    sellVM.updateText(newValue: newValue)
                }
            
            Spacer()
        }
    }
}
