//
//  MainCustomTabBar.swift
//  HeyDealerClone
//
//  Created by 우주형 on 2023/10/14.
//

import SwiftUI

enum MainTab: String, CaseIterable {
    case sell = "내차 팔 때"
    case buy = "내차 살 때"
    case lookAround = "차구경 👀"
}

struct MainCustomTabBar: View {
    @Binding var currentTab: MainTab
    @Namespace private var namespace
    var body: some View {
        HStack(spacing: 0) {
            ForEach(MainTab.allCases, id: \.rawValue) { tab in
                Button {
                    withAnimation(.easeInOut(duration: 0.24)) {
                        currentTab = tab
                    }
                } label: {
                    Text(tab.rawValue)
                        .foregroundColor(currentTab == tab ? currentTab == .sell ? .white : .black : .gray)
                        .customFont(fontWeight: .bold, size: 16)
                        .frame(width: 88)
                        .background(alignment: .bottom) {
                            if currentTab == tab {
                                Capsule()
                                    .fill(currentTab == tab ? currentTab == .sell ? .white : .black : .secondary)
                                    .frame(width: 62, height: 2)
                                    .offset(y: 16)
                                    .matchedGeometryEffect(id: "tabBar", in: namespace)
                            }
                        }
                }
            }
            Spacer()
        }
        .padding(.leading)
        .padding(.vertical, 26)
        .ignoresSafeArea(.container, edges: .bottom)
    }
    
}

