//
//  HeyDealerCloneApp.swift
//  HeyDealerClone
//
//  Created by 우주형 on 2023/10/14.
//

import SwiftUI

@main
struct HeyDealerCloneApp: App {
    @StateObject private var sellVM: SellViewModel = SellViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(sellVM)
//            OnboardingView()
//            CarView()
        }
    }
}
