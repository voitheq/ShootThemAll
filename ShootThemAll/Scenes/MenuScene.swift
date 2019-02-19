//
//  MenuScene.swift
//  ShootThemAll
//
//  Created by Wojciech Karaś on 11/02/2019.
//  Copyright © 2019 Wojciech Karaś. All rights reserved.
//

import SpriteKit

class MenuScene: ShootThemAllScene {
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        let buttonStart = Button(text: "START GAME", action: buttonStartTapped)
        buttonStart.scaleToWidth(width: frame.width, ratio: 0.6)
        buttonStart.position = CGPoint(x: frame.midX, y: frame.midY + buttonStart.frame.height)
        addChild(buttonStart)
        
        let buttonHowToPlay = Button(text: "HOW TO PLAY", action: buttonHowToPlayTapped)
        buttonHowToPlay.setFontSize(to: buttonStart.getFontSize())
        buttonHowToPlay.position = CGPoint(x: frame.midX, y: frame.midY - buttonHowToPlay.frame.height * 2)
        addChild(buttonHowToPlay)
        
    }
    
    private func buttonStartTapped() {
        sceneManagerDelegate?.presentGameScene()
    }
    
    private func buttonHowToPlayTapped() {
        sceneManagerDelegate?.presentHowToPlayScene()
    }
}
