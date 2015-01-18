//
//  Bait.swift
//  FishBait
//
//  Created by Mehdi Amini on 1/17/15.
//  Copyright (c) 2015 Mehdi Amini. All rights reserved.
//

import Foundation
import SpriteKit

class Bait : SKSpriteNode {
    var BaitUp : CGFloat
    var BaitDown : CGFloat

    init(BaitUp: CGFloat, BaitDown: CGFloat, size: CGSize) {
        self.BaitUp = BaitUp
        self.BaitDown = BaitDown
        let texture = SKTexture(imageNamed: "LadyBug.png")
        let color = UIColor.clearColor()
        super.init(texture: texture, color:color, size:size)

        self.position.y = BaitUp

        self.physicsBody = SKPhysicsBody(rectangleOfSize: self.size) // 1
        self.physicsBody?.dynamic = true
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = 1
        self.physicsBody?.contactTestBitMask = 2
        self.physicsBody?.collisionBitMask = 0

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func toggle() {
        if(Int(self.position.y) == Int(BaitUp)) {
            var positionDown = self.position
            positionDown.y = BaitDown
            var positionUp = self.position
            positionUp.y = BaitUp
            self.runAction(SKAction.sequence([SKAction.moveTo(positionDown, duration: 0.5),
                SKAction.moveTo(positionUp, duration: 0.5)]
                ))
        }
    }

    func catch(fish: SKNode) {
        fish.removeFromParent()
        fish.removeAllActions()
        fish.physicsBody?.categoryBitMask = 0
        fish.physicsBody?.contactTestBitMask = 0
        var rotation = -M_PI / 2.0
        let action = SKAction.rotateByAngle(CGFloat(rotation), duration: 0.1)
        fish.runAction(action)
        self.addChild(fish)
    }
}
