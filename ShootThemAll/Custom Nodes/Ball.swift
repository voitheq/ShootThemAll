//
//  Ball.swift
//  ShootThemAll
//
//  Created by Wojciech Karaś on 17/02/2019.
//  Copyright © 2019 Wojciech Karaś. All rights reserved.
//

import SpriteKit

class Ball: SKShapeNode {
    
    var wallCount = 0
    
    init(ballRadius: CGFloat) {
        super.init()
        
        strokeColor = UIColor.white
        fillColor = UIColor.white
        let ballSize = ballRadius * 2
        path = CGPath(ellipseIn: CGRect(x: -ballRadius, y: -ballRadius, width: ballSize, height: ballSize), transform: nil)
        physicsBody = SKPhysicsBody(circleOfRadius: ballRadius)
        physicsBody!.friction = 0
        physicsBody!.restitution = 0
        physicsBody!.categoryBitMask = PhysicsCategory.BALL
        physicsBody!.contactTestBitMask = PhysicsCategory.BLOCK | PhysicsCategory.ADD_BALL | PhysicsCategory.WALL | PhysicsCategory.FLOOR | PhysicsCategory.TOP
        physicsBody!.collisionBitMask = PhysicsCategory.BLOCK | PhysicsCategory.WALL | PhysicsCategory.FLOOR | PhysicsCategory.TOP
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
