//
//  Block.swift
//  ShootThemAll
//
//  Created by Wojciech Karaś on 11/02/2019.
//  Copyright © 2019 Wojciech Karaś. All rights reserved.
//

import SpriteKit

class Block: NetNode {
    
    private var label: SKLabelNode?
    var durability = 0 {
        didSet{
            if let label = label {
                label.text = String(durability)
            }
        }
    }
    var maxDurability = 0
    var killBall = true
    
    init(blockSize: CGFloat, fontSize: CGFloat, maxDurability: Int, color: UIColor){
        super.init()
        
        durability = max(1, Int.random(in: Int(maxDurability/2)...maxDurability))
        self.maxDurability = maxDurability
        
        strokeColor = color
        fillColor = color
        setColor()
        path = CGPath(rect: CGRect(x: -blockSize/2, y: -blockSize/2, width: blockSize, height: blockSize), transform: nil)
        physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: blockSize, height: blockSize))
        physicsBody!.friction = 0
        physicsBody!.restitution = 1
        physicsBody!.isDynamic = false
        physicsBody!.categoryBitMask = PhysicsCategory.BLOCK
        
        label = SKLabelNode(text: String(durability))
        label!.fontName = GameView.FONT_NAME
        label!.fontSize = fontSize
        label!.fontColor = UIColor.black
        label!.position = CGPoint(x: 0, y: -label!.frame.height/2)
        addChild(label!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func hit() -> Int {
        durability -= 1
        if durability == 0 {
            removeFromParent()
            return 1
        } else {
            setColor()
            return 0
        }
    }
    
    func setColor() {
        let color = UIColor.getGradientColor(from: fillColor, percentage: 1 - CGFloat(durability)/CGFloat(maxDurability))
        strokeColor = color
        fillColor = color
    }
}
