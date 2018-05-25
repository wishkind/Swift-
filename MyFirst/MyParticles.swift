//
//  MyParticles.swift
//  MyFirst
//
//  Created by sj on 11/02/2018.
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation
import SceneKit
class MyParticles: NSObject {

    init(_ scene: SCNScene) {
        let text = SCNText(string: "Good", extrusionDepth: 5)
        let node = SCNNode(geometry: text)
            scene.rootNode.addChildNode(node)
        let explode = SCNParticleSystem()
            explode.loops = false
            explode.birthRate = 5000
            explode.emissionDuration = 0.01
            explode.spreadingAngle = 180
            explode.particleDiesOnCollision = true
            explode.particleLifeSpan = 0.5
            explode.particleLifeSpanVariation = 0.3
            explode.particleVelocity = 500
            explode.particleVelocityVariation = 3
            explode.particleSize = 0.05
            explode.stretchFactor = 0.05
            explode.particleColor = UIColor.blue
        
            explode.emitterShape = nil
            explode.birthLocation = SCNParticleBirthLocation.surface
      
            scene.addParticleSystem(explode, transform: SCNMatrix4MakeRotation(0, 0, 0, 0))


    }
}
