//
//  LicenseTextField.swift
//  HeyDealerClone
//
//  Created by 우주형 on 2023/10/15.
//

import SwiftUI

struct LicenseTextField: View {
    @Binding var text: String
    @State private var licenseType: LicenseType = .normal
    @Binding var search: Bool
    @State private var blink: Bool = false
    
    @FocusState private var focused: Bool
    var body: some View {
        LicenseTextFieldObject(text: $text, blink: $blink, licenseType: $licenseType)
            .focused($focused)
            .onAppear { focused = true }
            .onTapGesture { focused = true }
            .onChange(of: focused) { self.blink = $0 }
            .animation(.easeInOut, value: licenseType)
            .onChange(of: text) { newValue in
                updateText(newValue: newValue)
            }
    }
}

//MARK: - Text 필터링
private extension LicenseTextField {
    func updateText(newValue: String) {
        // 숫자와 한글 이외에 필터링
        var filteredValue = CharacterSet.filterHangulAndNumbers(from: newValue)
                
        if let firstCharacter = filteredValue.first, firstCharacter.isNumber {
            filteredValue = processNumberCase(in: filteredValue)
        } else {
            filteredValue = processHangulCase(in: filteredValue)
        }
        text = filteredValue
    }
    
    func processNumberCase(in value: String) -> String {
        // 첫번째 숫자, 한글, 그리고 두번째 숫자로 나누기
        let firstNumbers = value.prefix{ $0.isNumber }
        let hangulAndSecondNumbers = value.dropFirst(firstNumbers.count)
        let hangul = hangulAndSecondNumbers.prefix{ CharacterSet.isJamo($0.unicodeScalars.first!) }
        let secondNumbers = hangulAndSecondNumbers.dropFirst(hangul.count).filter { $0.isNumber }
        
        // 첫번째 숫자는 최대 3자리
        var result = String(firstNumbers.count > 3 ? firstNumbers.prefix(3) : firstNumbers)
        
        // 한글은 한 글자만
        if hangul.count > 0, let firstHangul = hangul.first {
            result += String(firstHangul)
        }
        
        // 두번째 숫자는 최대 4자리
        result += String(secondNumbers.count > 4 ? String(secondNumbers.prefix(4)) : secondNumbers)
        
        /// 4개가 차면 검색 시작
        if secondNumbers.count == 4 {
            focused = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                withAnimation(.spring()) { search = true }
            }
        }
        
        return result
    }
    
    func processHangulCase(in value: String) -> String {
        let firstHangul = value.prefix { CharacterSet.isJamo($0.unicodeScalars.first!) }
        let numbersAndRest = value.dropFirst(firstHangul.count)
                
        var result = String(firstHangul.count > 2 ? firstHangul.prefix(2) : firstHangul)
        
        if numbersAndRest.count > 0 {
            let restString = processNumberCase(in: String(numbersAndRest))
            result += restString
            updateLicenseType(for: restString)
        }
        
        return result
    }
    
    //TODO: - 바,사,아,자 들어가면 yellow
    //TODO: - letter로 시작하고 위의 케이스 이외에 종성이 나오면 green
    //TODO: - 이외엔 normal
    func updateLicenseType(for restString: String) {
        if isYellowCase(restString) {
            licenseType = .yellow
        } else if isGreenCase(restString) {
            licenseType = .green
        } else {
            licenseType = .normal
        }
    }
    
    func isYellowCase(_ rest: String) -> Bool {
        ["바","사","아","자"].contains(where: {rest.contains($0)})
    }
    
    func isGreenCase(_ rest: String) -> Bool {
        let notGreenCase = ["바", "사", "아", "자", "ㅂ", "ㅇ", "ㅅ", "ㅈ"]
        return rest.containsHangul && !notGreenCase.contains(where: { rest.contains($0) })
    }
}
