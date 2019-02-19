//
//  GameOverScene.swift
//  ShootThemAll
//
//  Created by Wojciech Karaś on 11/02/2019.
//  Copyright © 2019 Wojciech Karaś. All rights reserved.
//

import SpriteKit

class GameOverScene: ShootThemAllScene {
    
    private var score = 0
    
    init(size: CGSize, score: Int) {
        super.init(size: size)
        self.score = score
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        let best = UserDefaults.standard.integer(forKey: Keys.BEST)
        if score > best {
            UserDefaults.standard.set(score, forKey: Keys.BEST)
        }
        
        let scoreLabel = SKLabelNode(text: String(score))
        scoreLabel.fontName = GameView.FONT_NAME
        scoreLabel.setFontSizeTo(height: frame.width, ratio: 0.2)
        scoreLabel.position = CGPoint(x: frame.midX, y: frame.maxY * 0.7)
        addChild(scoreLabel)
        
        let playAgainButton = Button(text: "PLAY AGAIN", action: playAgainButtonTapped)
        playAgainButton.scaleToWidth(width: frame.width, ratio: 0.6)
        playAgainButton.position = CGPoint(x: frame.midX, y: frame.midY + playAgainButton.frame.height)
        addChild(playAgainButton)
        
        let mainMenuButton = Button(text: "MAIN MENU", action: mainMenuButtonTapped)
        mainMenuButton.setFontSize(to: playAgainButton.getFontSize())
        mainMenuButton.position = CGPoint(x: frame.midX, y: frame.midY - mainMenuButton.frame.height * 2)
        addChild(mainMenuButton)
        
        view.isUserInteractionEnabled = true
    }
    
    func playAgainButtonTapped() {
        sceneManagerDelegate?.presentGameScene()
    }
    
    func mainMenuButtonTapped() {
        sceneManagerDelegate?.presentMenuScene()
    }
}
