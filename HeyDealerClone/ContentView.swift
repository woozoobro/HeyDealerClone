//
//  ContentView.swift
//  HeyDealerClone
//
//  Created by 우주형 on 2023/10/14.
//

import SwiftUI

struct ContentView: View {
    @State private var currentTab = MainTab.sell
    @State private var showMainView: Bool = false
    @AppStorage("showMain") var showMain: Bool = false
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        Group {
            if showMainView {
                ZStack(alignment: .top) {
                    Group {
                        if currentTab == .sell {
                            Color.theme.background
                        } else {
                            Color.white
                        }
                    }.ignoresSafeArea()
                        
                    MainCustomTabBar(currentTab: $currentTab)
                        .preferredColorScheme(currentTab == .sell ? .dark : .light)
                                        
                    RoundedRectangle(cornerRadius: 18)
                        .fill(Color.orange)
                        .overlay {
                            TabView(selection: $currentTab) {
                                SellView()
                                    .tag(MainTab.sell)
                                BuyView()
                                    .tag(MainTab.buy)
                                Text("차구경!")
                                    .tag(MainTab.lookAround)
                            }
                            .clipShape(RoundedRectangle(cornerRadius: 18))
                        }
                        .padding(.top, 68)
                        .ignoresSafeArea([.container, .keyboard], edges: .bottom)
                }
            } else {
                OnboardingView(showMainView: $showMainView)
            }
        }
        .onAppear {
            showMainView = showMain
        }
    }
}
