//
//  WebView.swift
//  HeyDealerClone
//
//  Created by 우주형 on 2023/10/14.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
   var urlString: String
   
   func makeUIView(context: Context) -> WKWebView {
      guard let url = URL(string: self.urlString) else {
         return WKWebView()
      }
      
      let webView = WKWebView()
      webView.load(URLRequest(url: url))
      return webView
   }
   
   func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<WebView>) { }
}
