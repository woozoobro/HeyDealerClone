//
//  Sidebar.swift
//  HeyDealerClone
//
//  Created by 우주형 on 2023/10/15.
//

import SwiftUI

struct Sidebar: View {
    @Binding var isSidebarVisible: Bool
    var sideBarWidth = UIScreen.main.bounds.size.width * 0.68
    var body: some View {
        ZStack {
            GeometryReader { _ in
                EmptyView()
            }
            .background(.black.opacity(0.4))
            .opacity(isSidebarVisible ? 1 : 0)
            .animation(.easeInOut(duration: 0.2), value: isSidebarVisible)
            .onTapGesture {
                isSidebarVisible.toggle()
            }
            menu
        }
        .ignoresSafeArea()
    }
    
    private var menu: some View {
        HStack {
            Spacer()
            ZStack(alignment: .top) {
                Color.white
                
                VStack(spacing: 40) {
                    Text("Heydealer")
                    Spacer()
                    SideMenuButton(title: "내차팔기 백과사전") { }
                    SideMenuButton(title: "자주묻는 질문") { }
                    SideMenuButton(title: "앱 정보") { }
                    SideMenuButton(title: "채팅 문의하기") { }
                }
                .padding(.vertical, 70)
            }
            .frame(width: sideBarWidth)
            .offset(x: isSidebarVisible ? 0 : sideBarWidth)
            .animation(.default, value: isSidebarVisible)
        }
    }
}

struct SideMenuButton: View {
    let title: String
    let action: () -> Void
    var body: some View {
        
        Button {
            action()
        } label: {
            HStack {
                Text(title)
                Spacer()
                Image(systemName: "chevron.right")
            }
            .customFont(fontWeight: .semiBold, size: 16)
            .foregroundColor(.theme.background)
            .padding(.horizontal, 20)
        }
    }
}
