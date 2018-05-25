//
//  PadOverlay.swift
//  MyFirst
//
//  Created by sj on 09/02/2018.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import SpriteKit
import simd
protocol  PadOverlayDelegate: NSObjectProtocol{
    func PadOverlayVisualStickInteractionDidStart(_ PadNode: PadOverlay)
    func PadOverlayVisualStickInteractionDidChange(_ PadNode: PadOverlay)
    func PadOverlayVisualStickInteractionDidEnd(_ PadNode: PadOverlay)
}
class PadOverlay: SKNode {
    var size = CGSize.zero {
        didSet {
            if size != oldValue {
            updateForSizeChange()
            }
        }
    }
    var stickPosition = CGPoint.zero {
        didSet {
            if stickPosition != oldValue {
            updateStickPosition()
            }
        }
    
    }
    weak var delegate: PadOverlayDelegate?
    private var trackingTouch: UITouch?
    private var startLocation = CGPoint.zero
    private var background: SKShapeNode!
    private var stick: SKShapeNode!
    override init() {
        super.init()
        size = CGSize(width: 150, height: 150)
        alpha = 0.7
        isUserInteractionEnabled = true
        buildPad()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder): has not been implemented")
    }
    func buildPad() {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        background = SKShapeNode()
        background.path = CGPath(ellipseIn: rect, transform: nil)
        background.strokeColor = SKColor.black
        background.lineWidth = 3
        addChild(background)
        let stickRect = CGRect.zero
    
        stick = SKShapeNode()
        stick.path = CGPath(ellipseIn: stickRect, transform: nil)
        stick.lineWidth = 2
        stick.fillColor = SKColor.white
        stick.strokeColor = SKColor.black
        addChild(stick)
        updateStickPosition()
        
    }
    
    var stickSize: CGSize {
        return CGSize(width: size.width / 3, height: size.height / 3)
    }
    func updateForSizeChange() {
        guard let background = background else{
            return
        }
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        background.path = CGPath(ellipseIn: rect, transform: nil)
        let stickRect = CGRect(x: 0, y: 0, width: size.width / 3, height: size.height / 3)
        stick.path = CGPath(ellipseIn: stickRect, transform: nil)
    }
    func updateStickPosition() {
        let stickSize: CGSize = self.stickSize
        let stickX = size.width / 2.0 - stickSize.width / 2.0 + size.width / 2 * stickPosition.x
        let stickY = size.height / 2.0 - stickSize.height / 2.0 + size.height / 2 * stickPosition.y
        stick.position = CGPoint(x: stickX, y: stickY)
        
    }
    func updateStickPosition(forTouchLocation location: CGPoint) {
        var l_vec = vector_float2(x: Float(location.x - startLocation.x), y: Float(location.y - startLocation.y))
    l_vec.x = (l_vec.x / Float(size.width) - 0.5 ) * 2
        l_vec.y = (l_vec.y / Float(size.height) - 0.5) * 2
        if simd_length_squared(l_vec) > 1 {
            l_vec = simd_normalize(l_vec)
        }
        stickPosition = CGPoint(x: CGFloat(l_vec.x), y: CGFloat(l_vec.y))
    }
    func resetInterraction() {
        trackingTouch = nil
        startLocation = CGPoint.zero
        stickPosition = CGPoint.zero
        delegate?.PadOverlayVisualStickInteractionDidEnd(self)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        trackingTouch = touches.first
        startLocation = trackingTouch!.location(in: self)
        startLocation.x -= size.width / 2
        startLocation.y -= size.height / 2
        updateStickPosition(forTouchLocation: trackingTouch!.location(in: self))
        delegate?.PadOverlayVisualStickInteractionDidStart(self)
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.contains(trackingTouch!) {
            updateStickPosition(forTouchLocation: trackingTouch!.location(in: self))
            delegate?.PadOverlayVisualStickInteractionDidChange(self)
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.contains(trackingTouch!) {
        resetInterraction()
        }
    }
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.contains(trackingTouch!) {
            resetInterraction()
        }
    }
    
}
