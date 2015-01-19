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
    var score=0
    var totalfishes=0
    var bg:SKSpriteNode!

    override func didMoveToView(view: SKView) {
        //get fish location move horizontal
        
        bg = SKSpriteNode(imageNamed: "waterwaves")
        bg.position = CGPointMake(self.position.x+self.size.width/2, self.position.y+self.size.height/2)
        
        self.addChild(bg)
        
        let moveAction = SKAction.moveByX(3.5, y: 0, duration: 0.02)
        let moveForeverAction = SKAction.repeatActionForever(moveAction)
        bg.runAction(moveForeverAction)
        
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
        self.bait = Bait(BaitUp: BaitUp, BaitDown: BaitDown, size: bait.size);
        self.bait?.position.x = CGRectGetMidX(self.frame)
        self.addChild(self.bait!);


        physicsWorld.contactDelegate = self
    }
    
    func addFish(){
        let fish = SKSpriteNode(imageNamed: "fish")
        fish.position=fishPosition
        fish.size=fishSize
        fish.physicsBody = SKPhysicsBody(rectangleOfSize: fish.size) // 1
        fish.physicsBody?.dynamic = true
        fish.physicsBody?.affectedByGravity = false
        fish.physicsBody?.categoryBitMask = 2
        fish.physicsBody?.contactTestBitMask = 1
        fish.physicsBody?.collisionBitMask = 0
        addChild(fish)
        totalfishes++
        let actionMoveStart = SKAction.moveTo(CGPoint(x: 0, y: fishPosition.y), duration: NSTimeInterval(5.0))
        let actionMoveDone = SKAction.removeFromParent()
        
        fish.runAction(SKAction.sequence([actionMoveStart , actionMoveDone]))

    }
    
    
    func didBeginContact(contact: SKPhysicsContact) {
        score=score+1
        println("Score:" + String(score))
         println("Total fishes:" + String(totalfishes))
        if let fish = contact.bodyA.node {
            if(fish != self.bait!) {
                self.bait?.catch(fish)
            }
        }
        if let fish = contact.bodyB.node {
            if(fish != self.bait!) {
                self.bait?.catch(fish)
               
                

            }
        }
        
    }
    
    func backgroundMovement() {
        println("backg x")
        println(bg.position.x)
        if(bg.position.x > 640)
        {
            bg.position.x = 0
        }
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        self.bait?.toggle()
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        backgroundMovement()
    }
}
