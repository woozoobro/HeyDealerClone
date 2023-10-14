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
    @State private var isSidebarVisible: Bool = false
    @AppStorage("showMain") var showMain: Bool = false
    @FocusState private var sellFocused: Bool
    @FocusState private var buyFocused: Bool
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        Group {
            if showMainView {
                ZStack {
                    ZStack(alignment: .top) {
                        Group {
                            if currentTab == .sell {
                                Color.theme.background
                            } else {
                                Color.white
                            }
                        }.ignoresSafeArea()
                        
                        HStack(spacing: 0) {
                            MainCustomTabBar(currentTab: $currentTab)
                                .preferredColorScheme(currentTab == .sell ? isSidebarVisible ? .light : .dark : .light)
                            
                            Button {
                                isSidebarVisible.toggle()
                                sellFocused = false
                                buyFocused = false
                            } label: {
                                Image(systemName: "list.bullet")
                                    .foregroundColor(currentTab == .sell ? .white : .theme.background)
                            }
                            .padding(.trailing,20)

                        }
                        
                        RoundedRectangle(cornerRadius: 18)
                            .fill(Color.orange)
                            .overlay {
                                TabView(selection: $currentTab) {
                                    SellView()
                                        .tag(MainTab.sell)
                                        .focused($sellFocused)
                                        .onAppear { sellFocused = true }
                                        .onTapGesture { sellFocused = false }
                                    
                                    BuyView()
                                        .tag(MainTab.buy)
                                        .focused($buyFocused)
                                        .onAppear { buyFocused = true }
                                        .onTapGesture { buyFocused = false }
                                    
                                    Text("차구경!")
                                        .tag(MainTab.lookAround)
                                }
                                .clipShape(RoundedRectangle(cornerRadius: 18))
                            }
                            .padding(.top, 68)
                            .ignoresSafeArea([.container, .keyboard], edges: .bottom)
                    }
                    
                    Sidebar(isSidebarVisible: $isSidebarVisible)
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
