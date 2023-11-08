//
//  CarView.swift
//  HeyDealerClone
//
//  Created by 우주형 on 2023/10/14.
//

import SwiftUI
import SceneKit

struct CarView: View {
   @State private var scene: SCNScene? = .init(named: "toy_car.scn")
   @State private var offset: CGFloat = 0
   @State private var showLicense: Bool = false
   @State private var moveLicense: Bool = false
   @Binding var showMainView: Bool
   var body: some View {
      ZStack {
         Color.blue.opacity(0.005)
            .ignoresSafeArea()
         CustomSceneView(scene: $scene)
            .frame(maxHeight: .infinity)
            .shadow(radius: 20)
            .onChange(of: offset) { newValue in
               rotateObject(animate: true)
            }
            .onAppear {
               withAnimation {
                  DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                     moveObjectToCenter()
                     offset = 720
                     DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                        scaleObjectWithAnimation()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                           fadeOutObject()
                        }
                     }
                  }
               }
            }
         
         if showLicense {
            NormalLicenseObject {
               MockLicenseText()
            }
            .rotation3DEffect(.zero, axis: (x: 0, y: 0, z: 0))
            .offset(y: moveLicense ? -80 : 150)
            .animation(.interactiveSpring(response: 0.7, dampingFraction: 0.6, blendDuration: 1), value: moveLicense)
         }
      }
      .transition(.opacity)
   }
   
   private func rotateObject(animate: Bool = false) {
      if animate {
         SCNTransaction.begin()
         SCNTransaction.animationDuration = 4
      }
      
      let newAngle = Float((offset * .pi) / -180)
      scene?.rootNode.eulerAngles.y = newAngle
      
      if animate {
         SCNTransaction.commit()
      }
   }
   
   private func moveObjectToCenter() {
      let moveAction = SCNAction.move(to: SCNVector3(0,0,0), duration: 3)
      scene?.rootNode.runAction(moveAction)
   }
   
   private func scaleObjectWithAnimation() {
      let scaleAction = SCNAction.scale(by: 2, duration: 1)
      scene?.rootNode.runAction(scaleAction)
      
   }
   
   private func fadeOutObject() {
      showLicense = true
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
         moveLicense = true
         DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            withAnimation {
               showMainView = true
            }
         }
      }
      let fadeOutAction = SCNAction.fadeOpacity(to: 0, duration: 0.3)
      scene?.rootNode.childNodes.forEach { node in
         node.runAction(fadeOutAction)
      }
   }
}
