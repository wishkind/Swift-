//
//  Monster.swift
//  MyFirst
//
//  Created by sj on 11/02/2018.
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation
import UIKit
import SceneKit
func extractAnimationsFromSceneSource(source: SCNSceneSource) {
    
    let animationsIDs = source.identifiersOfEntries(withClass: CAAnimation.self) as [String]
    var animations: [CAAnimation] = []
    for animationID in animationsIDs {
        if let animation = source.entryWithIdentifier(animationID, withClass: CAAnimation.self) {
            animations.append(animation)
        }
    }
    
}
class Monster {
    let node: SCNNode?
    let attackAnimation: CAAnimation?
    let urlString = "127.0.0.1"
    init() {
        let url = Bundle.main.url(forResource: urlString, withExtension: ".dae")!
        let sceneSource = SCNSceneSource.init(url: url, options: [SCNSceneSource.LoadingOption.animationImportPolicy: SCNSceneSource.AnimationImportPolicy.doNotPlay])
     node = sceneSource?.entryWithIdentifier("monster", withClass: SCNNode.self)

        attackAnimation = sceneSource?.entryWithIdentifier("monsterIdle", withClass: CAAnimation.self)
    }
    
    func playAttackAnimation() {
        node?.addAnimation(attackAnimation!, forKey: "attack")
    }
}
