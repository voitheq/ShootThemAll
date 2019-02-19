//
//  Top.swift
//  ShootThemAll
//
//  Created by Wojciech Karaś on 15/02/2019.
//  Copyright © 2019 Wojciech Karaś. All rights reserved.
//

import SpriteKit

class Top: SKShapeNode {

    var scoreLabel: SKLabelNode?
    var bestLabel: SKLabelNode?
    
    init(width: CGFloat, height: CGFloat) {
        super.init()
        
        strokeColor = UIColor.darkGray
        fillColor = UIColor.darkGray
        path = CGPath(rect: CGRect(x: -width/2, y: -height/2, width: width, height: height), transform: nil)
        physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: width, height: height))
        physicsBody!.friction = 0
        physicsBody!.restitution = 1
        physicsBody!.isDynamic = false
        physicsBody!.categoryBitMask = PhysicsCategory.TOP
        
        scoreLabel = SKLabelNode(text: "0")
        scoreLabel!.fontName = GameView.FONT_NAME
        scoreLabel!.setFontSizeTo(height: height, ratio: 0.5)
        scoreLabel!.position = CGPoint(x: 0, y: -scoreLabel!.frame.height/2)
        addChild(scoreLabel!)
        
        let bestDescLabel = SKLabelNode(text: "BEST")
        bestDescLabel.fontName = GameView.FONT_NAME
        bestDescLabel.setFontSizeTo(height: height, ratio: 0.22)
        addChild(bestDescLabel)
        
        bestLabel = SKLabelNode(text: "0")
        bestLabel!.fontName = GameView.FONT_NAME
        bestLabel!.setFontSizeTo(height: height, ratio: 0.40)
        addChild(bestLabel!)
        
        var pozX: CGFloat = 0
        if bestDescLabel.frame.width > bestLabel!.frame.width {
            pozX = -width/2 + bestDescLabel.frame.width
        } else {
            pozX = -width/2 + bestLabel!.frame.width
        }
        bestDescLabel.position = CGPoint(x: pozX, y: (height/2 - bestDescLabel.frame.height)/2)
        bestLabel!.position = CGPoint(x: pozX, y: -bestLabel!.frame.height)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
