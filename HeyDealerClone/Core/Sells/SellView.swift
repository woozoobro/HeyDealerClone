//
//  SellView.swift
//  HeyDealerClone
//
//  Created by 우주형 on 2023/10/15.
//

import SwiftUI

final class SellViewModel: ObservableObject {
    
    @Published var search: Bool = false
    
}

struct SellView: View {
    @StateObject private var vm: SellViewModel = SellViewModel()
    @State private var text: String = ""
    
    
    var body: some View {
        VStack(spacing: 40) {
            MainTitle(title: "먼저, 내 차 시세를\n알아볼까요?", fontColor: .theme.title)
                
            LicenseTextField(text: $text, search: $vm.search)
            
            Spacer()
            
            if vm.search {
                LoadingToast()
                    .transition(.move(edge: .bottom))
            }
        }
        
    }
}

struct LoadingToast: View {
    @State private var loading: Bool = false
    var body: some View {
        RoundedRectangle(cornerRadius: 8)
            .fill(Color.blue)
            .frame(height: 140)
            .shadow(radius: 3, y: 2)
            .overlay(alignment: .topLeading) {
                VStack(alignment: .leading) {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("모델명과 연식을")
                        Text("불러올게요.")
                    }
                    Spacer()
                    Circle()
                        .trim(from: 0, to: 0.9)
                        .stroke(lineWidth: 2)
                        .frame(width: 16)
                        .rotationEffect(.init(degrees: loading ? 360 : 0))
                        .animation(.easeInOut(duration: 1.2).repeatForever(autoreverses: false), value: loading)
                        .onAppear { loading.toggle() }
                }
                .customFont(fontWeight: .bold, size: 20)
                .padding(20)
            }
            .padding()
            .padding(.bottom, 30)
    }
}
