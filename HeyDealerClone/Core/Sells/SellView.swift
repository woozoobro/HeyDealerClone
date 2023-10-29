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
                    
                    if isSearching {
                        withAnimation(.spring()) {
                            self?.search = false
                        }
                    }
                }
            }
            .store(in: &cancellables)
    }
}

struct SellView: View {
    @StateObject private var vm: SellViewModel = SellViewModel()
    @State private var text: String = ""
    @EnvironmentObject private var navPathFinder: NavigationPathFinder
    
    
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
        .onChange(of: vm.showNavigation) { newValue in
            if newValue { navPathFinder.addPath(option: .sell(text: text)) }
        }
    }
}


