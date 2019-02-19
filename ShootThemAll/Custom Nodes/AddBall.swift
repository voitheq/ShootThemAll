//
//  AddBall.swift
//  ShootThemAll
//
//  Created by Wojciech Karaś on 15/02/2019.
//  Copyright © 2019 Wojciech Karaś. All rights reserved.
//

import SpriteKit

class AddBall: NetNode {

    init(ballRadius: CGFloat) {
        super.init()
        
        strokeColor = UIColor.white
        fillColor = UIColor.white
        let ballSize = ballRadius * 2
        path = CGPath(ellipseIn: CGRect(x: -ballRadius, y: -ballRadius, width: ballSize, height: ballSize), transform: nil)
        physicsBody = SKPhysicsBody(circleOfRadius: ballRadius)
        physicsBody!.isDynamic = false
        physicsBody!.categoryBitMask = PhysicsCategory.ADD_BALL
        let animTime = Double.random(in: 40..<80) / 100
        run(SKAction.repeatForever(SKAction.sequence([SKAction.scale(to: 1.6, duration: animTime), SKAction.scale(to: 1, duration: animTime)])))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
