//
//  NavigationPathFinder.swift
//  HeyDealerClone
//
//  Created by 우주형 on 2023/10/29.
//

import SwiftUI

final class NavigationPathFinder: ObservableObject {
    static let shared = NavigationPathFinder()
    private init() { }
    @Published var path: NavigationPath = .init()
    
    func addPath(option: ViewOptions) {
        path.append(option)
    }
    func popToRoot() {
        path = .init()
    }
}

enum ViewOptions: Hashable {
    case sell(text: String)
    @ViewBuilder func view() -> some View {
        switch self {
            case .sell(text: let license): SellDestinationView(license: license)
        }
    }
}
