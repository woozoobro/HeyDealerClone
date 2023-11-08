//
//  CharacterSet.swift
//  HeyDealerClone
//
//  Created by 우주형 on 2023/10/15.
//

import Foundation

extension CharacterSet {
   static let modernHangul: CharacterSet = CharacterSet(charactersIn: ("가".unicodeScalars.first!)...("힣".unicodeScalars.first!))
   static let numbers: CharacterSet = CharacterSet(charactersIn: "0123456789")
   
   static func isJamo(_ scalar: Unicode.Scalar) -> Bool {
      let value = scalar.value
      return (value >= 0x1100 && value <= 0x11FF) ||  // 초성
      (value >= 0x3130 && value <= 0x318F) ||  // 중성, 종성
      (value >= 0xAC00 && value <= 0xD7AF)     // 완성형 한글
   }
   
   static func filterHangulAndNumbers(from string: String) -> String {
      let allowedCharacters = modernHangul.union(.numbers)
      let filteredValue = string.unicodeScalars.filter { allowedCharacters.contains($0) || isJamo($0) }
      return String(String.UnicodeScalarView(filteredValue))
   }
}
