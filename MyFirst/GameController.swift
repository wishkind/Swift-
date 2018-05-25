//
//  GameController.swift
//  MyFirst
//
//  Created by sj on 10/02/2018.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import SceneKit
import GameplayKit
import GameController
struct Bitmask:OptionSet {
    let rawValue: Int
    static let character = Bitmask(rawValue: 1 << 0)
    static let collision = Bitmask(rawValue: 1 << 1)
    static let enemy = Bitmask (rawValue: 1 << 2)
    static let trigger = Bitmask(rawValue: 1 << 3)
    static let collectable = Bitmask(rawValue: 1 << 4)
    
}
enum ParticleKind: Int {
    case collect = 0
    case collectBig
    case keyApparition
    case enemyExplosion
    case unlockDoor
    case totalCount
}

enum AudioSourceKind: Int {
    case collect = 0
    case collectBig
    case unlockDoor
    case hitEnemy
    case totalCount
}
#if os(iOS)
    
    typealias Extra = SCNSceneRendererDelegate &  SCNPhysicsContactDelegate & MenuDelegate
        & PadOverlayDelegate & ButtonOverlayDelegate
#else
    typealias ExtraProtocols = SCNSceneRendererDelegate & SCNPhysicsContactDelegate & MenuDelegate
#endif
class GameController: NSObject,Extra {
    private var scene: SCNScene?
    private weak var sceneRenderer: SCNSceneRenderer?
     private var overlay: Overlay?
    
    func fStopChanged(_ value: CGFloat) {
     sceneRenderer!.pointOfView!.camera!.fStop = value
    }
    
    func focusDistanceChanged(_ value: CGFloat) {
        print("focusDistance")
    }
    
    func debugMenuSelectCameraAtIndex(_ index: Int) {
        print("debugMenu")
    }
    
    func PadOverlayVisualStickInteractionDidStart(_ PadNode: PadOverlay) {
        print("PadOver")
    }
    
    func PadOverlayVisualStickInteractionDidChange(_ PadNode: PadOverlay) {
        print("DidChange")
    }
    
    func PadOverlayVisualStickInteractionDidEnd(_ PadNode: PadOverlay) {
        print("DidEnd")
    }
    
    func willPress(_ button: ButtonOverlay) {
        print("willPress")
    }
    
    func didPress(_ button: ButtonOverlay) {
        print("DidPress")
    }
    

    
    
    
}
