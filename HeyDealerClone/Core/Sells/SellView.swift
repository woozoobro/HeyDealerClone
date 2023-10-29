//
//  SellView.swift
//  HeyDealerClone
//
//  Created by 우주형 on 2023/10/15.
//

import SwiftUI
import Combine

final class SellViewModel: ObservableObject {
    
    @Published var search: Bool = false
    @Published var showNavigation: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        setupSubscribers()
    }
    
    private func setupSubscribers() {
        $search
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isSearching in
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self?.showNavigation = isSearching
                    withAnimation(.spring()) {
                        self?.search = false
                    }
                }
            }
            .store(in: &cancellables)
    }
}

struct SellView: View {
    @StateObject private var vm: SellViewModel = SellViewModel()
    @State private var text: String = ""
    @Namespace private var namespace
    @Binding var path: NavigationPath
    
    
    var body: some View {
        VStack(spacing: 40) {
            MainTitle(title: "먼저, 내 차 시세를\n알아볼까요?", fontColor: .theme.title)
            
            LicenseTextField(text: $text, search: $vm.search)
                .matchedGeometryEffect(id: "LicenseTextField", in: namespace)
            
            Spacer()
            
            if vm.search {
                LoadingToast()
                    .transition(.move(edge: .bottom))
            }
        }
        .onChange(of: vm.showNavigation) { newValue in
            path.append(newValue)
        }
    }
}

struct LoadingToast: View {
    @State private var loading: Bool = false
    @State private var trim1: Bool = false
    @State private var trim2: Bool = false
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
                        .trim(from: 0, to: trim1 ? 1 : 0)
                        .trim(from: trim2 ? 1 : 0, to: 1)
                        .stroke(lineWidth: 2)
                        .frame(width: 16)
                        .rotationEffect(.init(degrees: loading ? 180 : 0))
                        .animation(.easeInOut(duration: 1.4).repeatForever(autoreverses: false), value: loading)
                        .animation(.easeInOut(duration: 2).repeatForever(autoreverses: false), value: trim1)
                        .animation(.easeInOut(duration: 4).repeatForever(autoreverses: true), value: trim2)
                        .onAppear {
                            loading.toggle()
                            trim1.toggle()
                            trim2.toggle()
                        }
                }
                .customFont(fontWeight: .bold, size: 20)
                .padding(20)
            }
            .padding()
            .padding(.bottom, 30)
    }
}