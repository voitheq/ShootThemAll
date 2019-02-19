//
//  ViewController.swift
//  ShootThemAll
//
//  Created by Wojciech Karaś on 11/02/2019.
//  Copyright © 2019 Wojciech Karaś. All rights reserved.
//

import UIKit
import SpriteKit

protocol SceneManagerDelegate: class {
    func presentMenuScene()
    func presentHowToPlayScene()
    func presentGameScene()
    func presentGameOverScene(score: Int)
}

class ShootThemAllViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        presentMenuScene()
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
}

extension ShootThemAllViewController: SceneManagerDelegate {
    func presentMenuScene() {
        let menuScene = MenuScene(size: view.bounds.size)
        present(scene: menuScene)
    }
    
    func presentHowToPlayScene() {
        let howToPlayScene = HowToPlayScene(size: view.bounds.size)
        present(scene: howToPlayScene)
    }
    
    func presentGameScene() {
        let gameScene = GameScene(size: view.bounds.size)
        present(scene: gameScene)
    }
    
    func presentGameOverScene(score: Int) {
        let gameOverScene = GameOverScene(size: view.bounds.size, score: score)
        present(scene: gameOverScene)
    }
    
    func present(scene: ShootThemAllScene) {
        if let view = view as? SKView {
            scene.sceneManagerDelegate = self
            scene.scaleMode = .aspectFit
            view.ignoresSiblingOrder = true
            view.showsFPS = false
            view.showsNodeCount = false
            view.showsPhysics = false
            view.presentScene(scene)
        }
    }
}

