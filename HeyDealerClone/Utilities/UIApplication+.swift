//
//  UIApplication+.swift
//  HeyDealerClone
//
//  Created by 우주형 on 2023/10/29.
//

import Foundation
import UIKit

///키보드 내리기
extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
