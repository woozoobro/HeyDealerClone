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
   @FocusState private var buyFocused: Bool
   @StateObject private var navPathFinder = NavigationPathFinder.shared
   
   init() { UITabBar.appearance().isHidden = true }
   
   var body: some View {
      Group {
         if showMainView {
            NavigationStack(path: $navPathFinder.path) {
               ZStack {
                  ZStack(alignment: .top) {
                     backgroundView
                     mainView
                  }
                  Sidebar(isSidebarVisible: $isSidebarVisible)
               }
               .navigationDestination(for: ViewOptions.self) { option in
                  option.view()
               }
            }
            .environmentObject(navPathFinder)
         } else {
            OnboardingView(showMainView: $showMainView)
         }
      }
      .onAppear {
         showMainView = showMain
      }
   }
}

//MARK: - Component
private extension ContentView {
   var backgroundView: some View {
      Group {
         if currentTab == .sell {
            Color.theme.background
         } else {
            Color.white
         }
      }
      .ignoresSafeArea()
   }
   
   var mainView: some View {
      VStack(spacing: 0) {
         HStack(spacing: 0) {
            MainCustomTabBar(currentTab: $currentTab)
               .preferredColorScheme(currentTab == .sell ? isSidebarVisible ? .light : .dark : .light)
            
            Button {
               isSidebarVisible.toggle()
               UIApplication.shared.endEditing()
               buyFocused = false
            } label: {
               Image(systemName: "list.bullet")
                  .foregroundColor(currentTab == .sell ? .white : .theme.background)
            }
            .padding(.trailing,20)
         }
         
         TabView(selection: $currentTab) {
            SellView()
               .tag(MainTab.sell)
               .background(.white)
               .ignoresSafeArea([.all, .keyboard], edges: .bottom)
               .onTapGesture {
                  UIApplication.shared.endEditing()
               }
            
            BuyView()
               .tag(MainTab.buy)
               .focused($buyFocused)
               .onAppear { buyFocused = true }
               .onTapGesture { buyFocused = false }
            
            ScrollView() {
               Text("차구경!")
               Rectangle()
            }
            .scrollDisabled(true)
            .background(Color.theme.background)
            .tag(MainTab.lookAround)
         }
         .clipShape(RoundedRectangle(cornerRadius: 18))
         .ignoresSafeArea([.all, .keyboard], edges: .bottom)
      }
   }
}
