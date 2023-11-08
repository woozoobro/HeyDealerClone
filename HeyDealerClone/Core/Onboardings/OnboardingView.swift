//
//  OnboardingView.swift
//  HeyDealerClone
//
//  Created by 우주형 on 2023/10/14.
//

import SwiftUI

struct OnboardingView: View {
   @State private var showPolicy = false
   @State private var showDisagree = false
   @State private var showCarView = false
   @Binding var showMainView: Bool
   @AppStorage("showMain") var showMain: Bool = false
   
   var body: some View {
      if !showCarView {
         VStack(spacing: 0) {
            Spacer()
            OnboardingAnimationView()
               .frame(height: 340)
            
            headerSection
            Spacer()
            
            policyButton
            agreeButton
            disagreeButton
         }
         .padding(.bottom, 20)
         .padding(.horizontal, 24)
         .transition(.opacity)
      } else {
         CarView(showMainView: $showMainView)
      }
   }
}

extension OnboardingView {
   private var headerSection: some View {
      VStack(alignment: .leading, spacing: 10) {
         Group {
            Text("번호판만")
            Text("입력하면")
               .padding(.bottom, 4)
         }
         .customFont(fontWeight: .semiBold, size: 32)
         
         VStack(alignment: .leading, spacing: 8) {
            Text("내차시세﹒이력﹒제원까지 알려드릴게요.")
            Text("헤이딜러로 팔지 않아도 분명 도움이 될 거예요.")
         }
         .customFont(fontWeight: .regular, size: 14)
      }
      .frame(maxWidth: .infinity, alignment: .leading)
      .padding(.horizontal, 20)
   }
   private var policyButton: some View {
      Button {
         showPolicy.toggle()
      } label: {
         HStack(spacing: 0) {
            Text("만 14세 이상이고, ")
            Text("개인정보 처리방침과 이용약관")
               .foregroundColor(.blue)
               .overlay(alignment:.bottom) { Rectangle().fill(.blue).frame(height: 0.5)}
            Text("에 동의하시나요?")
         }
         .customFont(fontWeight: .regular, size: 12)
      }
      .tint(.primary)
      .padding(.bottom)
      .sheet(isPresented: $showPolicy) {
         PolicyView()
      }
   }
   private var agreeButton: some View {
      Button {
         withAnimation {
            showCarView = true
            showMain = true
         }
      } label: {
         HStack {
            Text("동의하고 시작")
            Image(systemName: "chevron.right")
         }
         .foregroundColor(.white)
         .customFont(fontWeight: .bold, size: 16)
         .frame(height: 50)
         .frame(maxWidth: .infinity)
         .background {
            Color.blue.clipShape(RoundedRectangle(cornerRadius: 4))
         }
         .shadow(color: .blue.opacity(0.5), radius: 2, x: 0, y: 0)
      }
      .padding(.bottom, 2)
   }
   private var disagreeButton: some View {
      RoundedRectangle(cornerRadius: 4)
         .fill(showDisagree ? Color.theme.background : Color.clear)
         .frame(height: 56)
         .frame(maxWidth: .infinity)
         .animation(.easeInOut(duration: 0.6), value: showDisagree)
         .overlay {
            Text("⚠ 죄송합니다. 만 14세 미만이거나, 동의하지 않으시면 헤이딜러 이용이 어렵습니다.")
               .customFont(fontWeight: .bold, size: 15)
               .foregroundColor(.white)
               .padding(.horizontal)
         }
         .background(alignment:.bottom) {
            Button {
               showDisagree = true
            } label: {
               Text("만 14세 미만이거나 이용약관에 비동의합니다.")
                  .foregroundColor(.secondary)
                  .customFont(fontWeight: .light, size: 10)
            }
         }
         .onChange(of: showDisagree) { newValue in
            if newValue {
               DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                  showDisagree = false
               }
            }
         }
   }
}

struct PolicyView: View {
   @Environment(\.dismiss) private var dismiss
   let urlString = "https://remarkable-list-662507.framer.app"
   var body: some View {
      WebView(urlString: urlString)
         .ignoresSafeArea(.all, edges: .bottom)
         .safeAreaInset(edge: .top, alignment: .leading) {
            Button {
               dismiss()
            } label: {
               Image(systemName: "xmark")
                  .padding()
            }
            .tint(.primary)
         }
   }
}

