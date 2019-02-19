//
//  HowToPlayScene.swift
//  ShootThemAll
//
//  Created by Wojciech Karaś on 11/02/2019.
//  Copyright © 2019 Wojciech Karaś. All rights reserved.
//

import SpriteKit

class HowToPlayScene: ShootThemAllScene {
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        let buttonBack = Button(text: "BACK", action: buttonBackTapped)
        buttonBack.scaleToWidth(width: frame.width, ratio: 0.2)
        buttonBack.position = CGPoint(x: frame.midX, y: frame.minY + buttonBack.frame.height)
        addChild(buttonBack)
        
        let infoLabel = SKLabelNode(text: "THE IDEA IS TO BREAK AS MANY BRICKS AS YOU CAN BEFORE THEY TOUCH THE GROUND. YOU CAN MOVE YOUR BALL LEFT OR RIGHT BUT EVERY CHANGE COSTS YOU ONE POINT. IF YOUR BALL PASSES THROUGH WHITE CIRCLES YOU EARN EXTRA BALLS. EVERY TIME BALLS ARE RELOADED NEW ROW OF BRICKS IS CREATED.")
        infoLabel.fontName = GameView.FONT_NAME
        infoLabel.fontSize = buttonBack.getFontSize()
        infoLabel.numberOfLines = 0
        infoLabel.lineBreakMode = .byWordWrapping
        infoLabel.preferredMaxLayoutWidth = frame.width * 0.9
        infoLabel.position = CGPoint(x: frame.midX, y: frame.midY - infoLabel.frame.height/2)
        addChild(infoLabel)
        
    }
    
    private func buttonBackTapped() {
        sceneManagerDelegate?.presentMenuScene()
    }
}
