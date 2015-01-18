//
//  GameScene.swift
//  FishBait
//
//  Created by Mehdi Amini on 1/17/15.
//  Copyright (c) 2015 Mehdi Amini. All rights reserved.
//

import SpriteKit
//import Bait

class GameScene: SKScene , SKPhysicsContactDelegate{
    
    var fishPosition:CGPoint!
    var fishSize:CGSize!
    var bait : Bait?

    override func didMoveToView(view: SKView) {
        //get fish location move horizontal
        let fish = childNodeWithName("fish") as SKSpriteNode
        fishPosition = fish.position;
        fishSize = fish.size
        fish.removeFromParent()
        runAction(SKAction.repeatActionForever(
            SKAction.sequence([
                SKAction.runBlock(addFish),
                SKAction.waitForDuration(3.0)
                ])
            ))

        /* Setup bait */
        let bait = childNodeWithName("bait") as SKSpriteNode
        bait.removeFromParent()
        var BaitUp : CGFloat = bait.position.y
        var BaitDown : CGFloat = fish.position.y;
        self.bait = Bait(BaitUp: BaitUp, BaitDown: BaitDown);
        self.bait?.position.x = CGRectGetMidX(self.frame)
        self.bait?.size = bait.size
        self.addChild(self.bait!);


        physicsWorld.contactDelegate = self
    }
    
    func addFish(){
        let fish = SKSpriteNode(imageNamed: "fish")
        fish.position=fishPosition
        fish.size=fishSize
        fish.physicsBody = SKPhysicsBody(rectangleOfSize: fish.size) // 1
        fish.physicsBody?.dynamic = false
        fish.physicsBody?.categoryBitMask = 1
        fish.physicsBody?.contactTestBitMask = 1
        fish.physicsBody?.collisionBitMask = 0
        addChild(fish)
        let actionMoveStart = SKAction.moveTo(CGPoint(x: 0, y: fishPosition.y+fishSize.height), duration: NSTimeInterval(5.0))
        let actionMoveDone = SKAction.removeFromParent()
        
        fish.runAction(SKAction.sequence([actionMoveStart , actionMoveDone]))

    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        self.bait?.toggle()
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
