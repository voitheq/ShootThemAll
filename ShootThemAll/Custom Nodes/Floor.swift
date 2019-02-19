//
//  Floor.swift
//  ShootThemAll
//
//  Created by Wojciech Karaś on 14/02/2019.
//  Copyright © 2019 Wojciech Karaś. All rights reserved.
//

import SpriteKit

class Floor: SKShapeNode {
    
    var numLeftLabel: SKLabelNode?
    var numAllLabel: SKLabelNode?
    
    init(width: CGFloat, height: CGFloat) {
        super.init()

        strokeColor = UIColor.darkGray
        fillColor = UIColor.darkGray
        path = CGPath(rect: CGRect(x: -width/2, y: -height/2, width: width, height: height), transform: nil)
        physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: width, height: height))
        physicsBody!.friction = 0
        physicsBody!.restitution = 1
        physicsBody!.isDynamic = false
        physicsBody!.categoryBitMask = PhysicsCategory.FLOOR
        
        numLeftLabel = SKLabelNode(text: "0")
        numLeftLabel!.fontName = GameView.FONT_NAME
        numLeftLabel!.setFontSizeTo(height: height, ratio: 0.35)
        numLeftLabel!.position = CGPoint(x: 0, y: (height/2 - numLeftLabel!.frame.height)/2)
        addChild(numLeftLabel!)
        
        numAllLabel = SKLabelNode(text: "0")
        numAllLabel!.fontName = GameView.FONT_NAME
        numAllLabel!.setFontSizeTo(height: height, ratio: 0.22)
        numAllLabel!.position = CGPoint(x: 0, y: -numAllLabel!.frame.height)
        addChild(numAllLabel!)
        
    }
        
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
