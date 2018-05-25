//
//  Character.swift
//  MyFirst
//
//  Created by sj on 09/02/2018.
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation
import SceneKit
import simd


class Character: NSObject {
    static private let  speedFactor: CGFloat = 2.0
    static private let stepsCount = 10
    static private let initialPosition = float3(0.1, -0.2, 0)
    static private let gravity = Float(0.4)
    static private let jumpPulse = Float(0.1)
    static private  let minAltitude = Float(-10)
    static private let enableFootStepSound = true
    static private let collisionMargin = Float(0.4)
    static private let modelOffset = float3(0, -collisionMargin, 0)
    static private let collisionBitMask = 8
    enum GroundType {
       case  water
        case grass
        case rock
        case inTheAir
        case count
        
    }
    private var character: SCNNode!
    private var  characterOrientation: SCNNode!
    private var model: SCNNode!
    
    //physics
    private var characterCollisionShape: SCNPhysicsShape?
    private var collisionOffestFromModel = float3.zero
    private var downwardAcceleration: Float = 0
    
    //Jump
    private var controllerJump: Bool = false
    private var jumpState: Int = 0
    private var groudNode: SCNNode?
    private var groundNodeLastPosition = float3.zero
    var baseAltitude = Float(0)
    private var targetAltitude: Float = 0
    
    //plyaying step sound frequency
    private var lastStepFrame: Int = 0
    private var frameCounter: Int = 0
    
    //Direction
    private var previousUpdateTime: TimeInterval = 0
    private var controllerDirection = float2.zero
    
    //States
    private var attackCount: Int = 0
    private var lastHitTime: TimeInterval = 0
    private var shouldResetCharacterPosition: Bool = false
    
    //ParticleSystems
    
    private var jumpDustParticle: SCNParticleSystem!
    private  var fireEmitter: SCNParticleSystem!
    private var smokeEmitter: SCNParticleSystem!
    private var whiteSmokeEmitter: SCNParticleSystem!
    private var spinParticle: SCNParticleSystem!
    private var spinCircleParticle: SCNParticleSystem!
    private var spinParticleAttach: SCNNode!
    
    private var fireEitterBirthRate: Float = 0
    private var smokeEmitterBirthRate: Float = 0
    private var whiteEmitterBirthRate: Float = 0
    
    
    //Sound
    private var aahSound: SCNAudioSource!
    private var ouchSound: SCNAudioSource!
    private var hitSound: SCNAudioSource!
    private var hitEnemySound: SCNAudioSource!
    private var explodeEnemySound: SCNAudioSource!
    private var catchFireSound: SCNAudioSource!
    private var jumpSound: SCNAudioSource!
    private var attackSoud: SCNAudioSource!
    private var steps  = [SCNAudioSource](repeating: SCNAudioSource(), count: Character.stepsCount)
    private(set) var offsetMark: SCNNode?
    
    
    //Action
    
    var isJump: Bool = false
    var direction = float2()
    var physicsWorld: SCNPhysicsWorld?
    
    init(scene: SCNScene) {
       super.init()
        loadCharacter()
        loadParticles()
        loadSounds()
        loadAnimations()
    }
        
    func loadCharacter() {

        let url = URL(string: "127.0.0.1/Assets/character/max.scn")
               let url1 = URL(string: "127.0.0.1/Assets/character")
        let sceneSource = SCNSceneSource(url: url!, options: [SCNSceneSource.LoadingOption.animationImportPolicy : SCNSceneSource.AnimationImportPolicy.doNotPlay])!
        if sceneSource != nil {
            print("ok")
        }

        let dd  = SCNSceneSource(url: url!, options: [SCNSceneSource.LoadingOption.assetDirectoryURLs: url])
     
    }
    
    func loadParticles(){
        
    }
    func loadSounds() {
        
    }
    func loadAnimations() {
        
    }
    }
    
    
    
    

