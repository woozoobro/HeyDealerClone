//
//  CustomSceneView.swift
//  HeyDealerClone
//
//  Created by 우주형 on 2023/10/14.
//

import SwiftUI
import SceneKit

struct CustomSceneView: UIViewRepresentable {
    @Binding var scene: SCNScene?
    func makeUIView(context: Context) -> SCNView {
        let view = SCNView()
        view.allowsCameraControl = false
        view.autoenablesDefaultLighting = true
        view.antialiasingMode = .multisampling2X
        view.backgroundColor = .clear
        
        view.scene = scene
        
        view.scene?.rootNode.scale = SCNVector3(0.5, 0.5, 0.5)
        view.scene?.rootNode.position = SCNVector3(40, 0, 0)
        
        return view
    }
    
    func updateUIView(_ uiView: SCNView, context: Context) {
        
    }
}
