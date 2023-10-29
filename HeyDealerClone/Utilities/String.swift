//
//  String.swift
//  HeyDealerClone
//
//  Created by 우주형 on 2023/10/28.
//

import Foundation

extension String {
    var containsHangul: Bool {
        unicodeScalars.contains { CharacterSet.isJamo($0) }
    }
}
