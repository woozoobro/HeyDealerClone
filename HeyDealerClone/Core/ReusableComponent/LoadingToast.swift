//
//  LoadingToast.swift
//  HeyDealerClone
//
//  Created by 우주형 on 2023/10/29.
//

import SwiftUI

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
