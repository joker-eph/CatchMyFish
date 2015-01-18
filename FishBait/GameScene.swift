//
//  GameScene.swift
//  FishBait
//
//  Created by Mehdi Amini on 1/17/15.
//  Copyright (c) 2015 Mehdi Amini. All rights reserved.
//

import SpriteKit

class GameScene: SKScene , SKPhysicsContactDelegate{
    
    var fishPosition:CGPoint!
    var fishSize:CGSize!
    
    override func didMoveToView(view: SKView) {
        //get fish location move horizontal
        
        
        let fish = childNodeWithName("fish") as SKSpriteNode
        if(fishPosition == nil){
            fishPosition = fish.position;
        }
        if(fishSize == nil){
            fishSize = fish.size
        }
        fish.removeFromParent()
        runAction(SKAction.repeatActionForever(
            SKAction.sequence([
                SKAction.runBlock(addFish),
                SKAction.waitForDuration(3.0)
                ])
            ))
        physicsWorld.contactDelegate = self
    }
    
    func addFish(){
        let fish = SKSpriteNode(imageNamed: "fish")
        fish.position=fishPosition
        fish.size=fishSize
        fish.physicsBody = SKPhysicsBody(rectangleOfSize: fish.size) // 1
        fish.physicsBody?.dynamic = true
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
        
       /* for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            
            let sprite = SKSpriteNode(imageNamed:"Spaceship")
            
            sprite.xScale = 0.5
            sprite.yScale = 0.5
            sprite.position = location
            
            let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:1)
            
            sprite.runAction(SKAction.repeatActionForever(action))
            
            self.addChild(sprite)
        }*/
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
