//
//  Button.swift
//  ShootThemAll
//
//  Created by Wojciech Karaś on 11/02/2019.
//  Copyright © 2019 Wojciech Karaś. All rights reserved.
//

import SpriteKit

class Button: SKSpriteNode {
    
    var label: SKLabelNode
    var action: () -> ()
    
    init(text: String, action: @escaping () -> ()) {
        self.action = action
        label = SKLabelNode(text: text)
        label.fontName = GameView.FONT_NAME
        super.init(texture: nil, color: UIColor.clear, size: label.frame.size)
        isUserInteractionEnabled = true
        addChild(label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        label.run(SKAction.fadeAlpha(to: 0.6, duration: 0.2))
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            label.contains(location) ? label.run(SKAction.fadeAlpha(to: 0.6, duration: 0.3)) : label.run(SKAction.fadeAlpha(to: 1, duration: 0.2))
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        label.run(SKAction.fadeAlpha(to: 1, duration: 0.3))
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        label.run(SKAction.fadeAlpha(to: 1, duration: 0.3))
        if let touch = touches.first {
            let location = touch.location(in: self)
            if label.contains(location) {
                action()
            }
        }
    }
    
    func scaleToWidth(width: CGFloat, ratio: CGFloat) {
        label.setFontSizeTo(width: width, ratio: ratio)
        size = label.frame.size
    }
    
    func scaleToHeight(height: CGFloat, ratio: CGFloat) {
        label.setFontSizeTo(height: height, ratio: ratio)
        size = label.frame.size
    }
    
    func setFontSize(to size: CGFloat) {
        label.fontSize = size
    }
    
    func getFontSize() -> CGFloat {
        return label.fontSize
    }
    
}
