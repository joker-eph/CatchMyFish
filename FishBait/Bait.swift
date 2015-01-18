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
        self.physicsBody?.contactTestBitMask = 1
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
            self.runAction(SKAction.sequence([SKAction.moveTo(positionDown, duration: 0.5)]
                ))
        }
    }
}
