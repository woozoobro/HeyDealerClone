//
//  CarView.swift
//  HeyDealerClone
//
//  Created by 우주형 on 2023/10/14.
//

import SwiftUI
import SceneKit

struct CarView: View {
    @State var scene: SCNScene? = .init(named: "toy_car.scn")
    @State var offset: CGFloat = 0
    @State var showLicense: Bool = false
    @State var moveLicense: Bool = false
    var body: some View {
        ZStack {
            CustomSceneView(scene: $scene)
                .frame(maxHeight: .infinity)
                .shadow(radius: 20)
                .onChange(of: offset) { newValue in
                    rotateObject(animate: true)
                }
                .onAppear {
                    withAnimation {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            moveObjectToCenter()
                            offset = 720
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                scaleObjectWithAnimation()
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                    fadeOutObject()
                                }
                            }
                        }
                    }
                }
            
            if showLicense {
                LicenseObject(title: "12가 3425")
                    .rotation3DEffect(.zero, axis: (x: 0, y: 0, z: 0))
                    .offset(y: moveLicense ? -200 : 0)
                    .animation(.interactiveSpring(response: 0.3, dampingFraction: 0.6, blendDuration: 1), value: moveLicense)
            }
        }
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
        let moveAction = SCNAction.move(to: SCNVector3(0,0,0), duration: 2)
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
        }
        let fadeOutAction = SCNAction.fadeOpacity(to: 0, duration: 0.3)
        scene?.rootNode.childNodes.forEach { node in
            node.runAction(fadeOutAction)
        }
    }
}

struct CarView_Previews: PreviewProvider {
    static var previews: some View {
        CarView()
    }
}
