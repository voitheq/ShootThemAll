//
//  GameScene.swift
//  ShootThemAll
//
//  Created by Wojciech Karaś on 11/02/2019.
//  Copyright © 2019 Wojciech Karaś. All rights reserved.
//

import SpriteKit

class GameScene: ShootThemAllScene {
    
    private var netSize: CGFloat = 0
    private var blockSize: CGFloat = 0
    private var ballRadius: CGFloat = 0
    private var addBallRadius: CGFloat = 0
    private var numRows = 0
    private var addHeight: CGFloat = 0
    private var pozY: CGFloat = 0
    private var fontSize: CGFloat = 0
    
    private var ball: Ball?
    private var ballPosition = CGPoint(x: 0, y: 0)
    private var floor: Floor?
    private var top: Top?
    
    private var gameOver = false
    
    private var score = 0 {
        didSet{
            if score < 0 {
                score = 0
            }
            if score != oldValue {
                checkBlocks()
            }
            if let top = top {
                top.scoreLabel?.text = "\(score)"
            }
        }
    }
    private var durability = 0
    private var drag = false
    
    private var leftBalls = 0 {
        didSet {
            if let floor = floor {
                floor.numLeftLabel?.text = "\(leftBalls)"
            }
        }
    }
    private var allBalls = 0 {
        didSet {
            if let floor = floor {
                floor.numAllLabel?.text = "(\(allBalls))"
            }
        }
    }
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        physicsBody?.friction = 0
        physicsBody?.restitution = 1
        physicsBody?.categoryBitMask = PhysicsCategory.WALL
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        physicsWorld.contactDelegate = self
        
        netSize = frame.width / CGFloat(GameSettings.NUM)
        blockSize = netSize - 2.0 * GameSettings.SPACE
        ballRadius = netSize / 5.5
        addBallRadius = netSize / 8.5
        numRows = Int((frame.height - netSize * 2) / netSize)
        addHeight = (frame.height - netSize * 2).truncatingRemainder(dividingBy: netSize) / 2
        fontSize = getFontSize()
        
        insertFloor()
        ballPosition = CGPoint(x: frame.midX, y: floor!.frame.height + ballRadius*2)
        insertTop()
        pozY = frame.maxY - top!.frame.height/2
        leftBalls = 1
        allBalls = 1
        durability = 2
        insertRow()
        moveDown()
        insertBall()
        
        let best = UserDefaults.standard.integer(forKey: Keys.BEST)
        top!.bestLabel?.text = "\(best)"
        
        let backButton = Button(text: "<--", action: backButtonTapped)
        backButton.scaleToHeight(height: netSize, ratio: 0.22)
        backButton.position = CGPoint(x: backButton.frame.width * 0.65, y: floor!.frame.height/2 - backButton.frame.height/2)
        backButton.zPosition = zPositions.BACK
        addChild(backButton)
        
    }
    
    private func insertFloor() {
        floor = Floor(width: frame.width, height: netSize + addHeight)
        floor!.zPosition = zPositions.FLOOR
        floor!.position = CGPoint(x: frame.width/2, y: floor!.frame.height/2)
        addChild(floor!)
    }
    
    private func insertTop() {
        top = Top(width: frame.width, height: netSize + addHeight)
        top!.zPosition = zPositions.TOP
        top!.position = CGPoint(x: frame.width/2, y: frame.maxY - top!.frame.height/2)
        addChild(top!)
    }
    
    private func insertRow() {
        
        let newBallIndex = Int.random(in: 0..<GameSettings.NUM)
        var newBlockIndex = 0
        repeat {
            newBlockIndex = Int.random(in: 0..<GameSettings.NUM)
        } while newBlockIndex == newBallIndex
        let color = UIColor.getColor()
        
        for i in 0..<GameSettings.NUM {
            if i == newBallIndex {
                if Int.random(in: 0..<100) <= GameSettings.ADD_BALL_RANDOM_PERC {
                    let addBall = AddBall(ballRadius: addBallRadius)
                    addBall.zPosition = zPositions.ADD_BALL
                    addBall.position = CGPoint(x: frame.minX + netSize * CGFloat(i) + netSize/2, y: pozY)
                    addChild(addBall)
                }
            } else {
                if Int.random(in: 0..<100) <= GameSettings.BLOCK_RANDOM_PERC || i == newBlockIndex{
                    let block = Block(blockSize: blockSize, fontSize: fontSize, maxDurability: durability, color: color)
                    block.zPosition = zPositions.BLOCK
                    block.position = CGPoint(x: frame.minX + netSize * CGFloat(i) + netSize/2, y: pozY)
                    addChild(block)
                }
            }
        }
        
        durability += 1
    }
    
    private func moveDown() {
        for child in children {
            if let netNode = child as? NetNode {
                if netNode.moveDown {
                    netNode.run(SKAction.move(by: CGVector(dx: 0, dy: -netSize * netNode.stepOnNet), duration: 0.2)) {
                        if let block = netNode as? Block {
                            block.killBall = false
                        }
                    }
                    netNode.stepOnNet = 1
                    netNode.row += 1
                    if self.gameOver == false {
                        self.checkNode(netNode: netNode)
                    }
                }
            }
        }
    }
    
    private func checkNode(netNode: NetNode) {
        if let block = netNode as? Block {
            if block.row == numRows - 1 {
                gameOver = true
                view?.isUserInteractionEnabled = false
                run(SKAction.sequence([SKAction.wait(forDuration: 1.5), SKAction.run({
                    self.sceneManagerDelegate?.presentGameOverScene(score: self.score)
                })]))
            }
            
        } else if let addBall = netNode as? AddBall {
            if addBall.row == numRows {
                addBall.removeFromParent()
            }
        }
    }
    
    private func insertBall() {
        if ball == nil && leftBalls > 0 && gameOver == false{
            leftBalls -= 1
            ball = Ball(ballRadius: ballRadius)
            ball!.zPosition = zPositions.BALL
            ball!.position = ballPosition
            ball!.xScale = 0.01
            ball!.yScale = 0.01
            ball!.run(SKAction.scale(to: 1, duration: 0.15))
            addChild(ball!)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            if let ball = ball {
                if ball.contains(location) {
                    drag = true
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            if let ball = ball {
                if drag {
                    ballPosition = CGPoint(x: location.x, y: ball.position.y)
                    ball.position = ballPosition
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if drag {
            drag = false
            score -= GameSettings.PENALTY
        } else {
            if let ball = ball {
                if let touch = touches.first {
                    let location = touch.location(in: self)
                    let dx =  location.x - ball.position.x
                    let dy =  location.y - ball.position.y
                    ball.physicsBody?.velocity = CGVector(dx: dx, dy: dy)
                    setBallSpeed(ball: ball)
                    self.ball = nil
                    insertBall()
                }
            } else if leftBalls == 0{
                reloadBalls()
            }
        }
    }
    
    func reloadBalls() {
        if gameOver == false {
            leftBalls = allBalls
            insertRow()
            moveDown()
            insertBall()
        }
    }
    
    func checkBlocks() {
        for child in children {
            if let _ = child as? Block {
                return
            }
        }
        reloadBalls()
    }
    
    func setBallSpeed(ball: Ball) {
        if let physicsBody = ball.physicsBody {
            let length = sqrt(pow(physicsBody.velocity.dx, 2) + pow(physicsBody.velocity.dy, 2))
            physicsBody.velocity = CGVector(dx: (physicsBody.velocity.dx/length) * GameSettings.SPEED, dy: (physicsBody.velocity.dy/length) * GameSettings.SPEED)
        }
    }
    
    func getFontSize() -> CGFloat {
        let testLabel = SKLabelNode(text: "0")
        testLabel.setFontSizeTo(height: blockSize, ratio: 0.3)
        return testLabel.fontSize
    }
    
    private func backButtonTapped() {
        sceneManagerDelegate?.presentMenuScene()
    }
}

//MARK: - PhysicsContactDelegate Methods
extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        let mask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        switch mask {
        case PhysicsCategory.BALL | PhysicsCategory.BLOCK:
            if let block = contact.bodyA.node as? Block, let ball = contact.bodyB.node as? Ball {
                blockHit(block: block, ball: ball)
                
            }else if let block = contact.bodyB.node as? Block, let ball = contact.bodyA.node as? Ball {
                blockHit(block: block, ball: ball)
            }
        case PhysicsCategory.BALL | PhysicsCategory.ADD_BALL:
            if contact.bodyA.categoryBitMask == PhysicsCategory.ADD_BALL, let ball = contact.bodyB.node as? Ball {
                addBallHit(body: contact.bodyA)
                setBallSpeed(ball: ball)
                
            } else if contact.bodyB.categoryBitMask == PhysicsCategory.ADD_BALL, let ball = contact.bodyA.node as? Ball {
                addBallHit(body: contact.bodyB)
                setBallSpeed(ball: ball)
            }
        case PhysicsCategory.BALL | PhysicsCategory.WALL, PhysicsCategory.BALL | PhysicsCategory.TOP:
            if let ball = contact.bodyA.node as? Ball {
                wallHit(ball: ball)
                
            } else if let ball = contact.bodyB.node as? Ball {
                wallHit(ball: ball)
            }
        case PhysicsCategory.BALL | PhysicsCategory.FLOOR:
            if contact.bodyA.categoryBitMask == PhysicsCategory.BALL {
                ballHitFloor(body: contact.bodyA)
                
            } else if contact.bodyB.categoryBitMask == PhysicsCategory.BALL {
                ballHitFloor(body: contact.bodyB)
            }
        default:
            break
        }
    }
    
    func wallHit(ball: Ball) {
        if ball.wallCount == 30 {
            ball.wallCount = 0
            let dx =  CGFloat.random(in: 0..<frame.maxX) - ball.position.x
            let dy =  CGFloat.random(in: 0..<frame.maxY) - ball.position.y
            ball.physicsBody?.velocity = CGVector(dx: dx, dy: dy)
        } else {
            ball.wallCount += 1
        }
        setBallSpeed(ball: ball)
    }
    
    func blockHit(block: Block, ball: Ball) {
        if gameOver == false {
            if block.killBall == true {
                ball.removeFromParent()
            } else {
                score += block.hit()
                ball.wallCount = 0
                setBallSpeed(ball: ball)
            }
        }
    }
    
    func addBallHit(body: SKPhysicsBody) {
        if gameOver == false {
            body.categoryBitMask = PhysicsCategory.NONE
            if let ball = body.node as? NetNode {
                ball.moveDown = false
                let targetY = netSize + ball.frame.height/2
                let road = ball.frame.minY - targetY
                ball.run(SKAction.moveTo(y: targetY, duration: TimeInterval(road/650))) {
                    ball.removeFromParent()
                    self.allBalls += 1
                }
            }
        }
    }
    
    func ballHitFloor(body: SKPhysicsBody) {
        if ball == nil && leftBalls == 0{
            reloadBalls()
        }
        body.velocity = CGVector.zero
        body.node?.removeFromParent()
    }
}
