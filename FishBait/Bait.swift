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
    var isDown = false
    var BaitUp : CGFloat
    var BaitDown : CGFloat

    init(BaitUp: CGFloat, BaitDown: CGFloat) {
        self.BaitUp = BaitUp
        self.BaitDown = BaitDown
        let texture = SKTexture(imageNamed: "LadyBug.png")
        let color = UIColor.clearColor()
        println(texture.size())
        super.init(texture: texture, color:color, size:texture.size())

        self.position.y = BaitUp

        self.physicsBody = SKPhysicsBody(rectangleOfSize: self.size) // 1
        self.physicsBody?.dynamic = true
        self.physicsBody?.categoryBitMask = 1
        self.physicsBody?.contactTestBitMask = 1
        //self.physicsBody?.collisionBitMask = 0

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func toggle() {
        var position = self.position
        if(isDown) {
            position.y = self.BaitUp
        } else {
            position.y = self.BaitDown
        }
        self.runAction(SKAction.moveTo(position, duration: 0.5))

        isDown = !isDown
    }
}
