//
//  GameScene.swift
//  LR
//
//  Created by 佐藤亘 on 2018/06/13.
//  Copyright © 2018年 佐藤亘. All rights reserved.
//

import SpriteKit
import GameplayKit

protocol DialogDelegate: NSObjectProtocol {
    func showDialog(score : Int)
}

class GameScene: SKScene {
    
    private var spinnyNode : SKShapeNode?
    private var allChar : [SKSpriteNode] = []
    private var nodeArray : [SKSpriteNode] = []
    private var x_positions : [CGFloat] = []
    private var scoreLabel : SKLabelNode!
    private var score : Int = 0
    private var lastChar : CFTimeInterval!
    weak var myDelegate: DialogDelegate?
    
    override func didMove(to view: SKView) {
        let x1 = size.width / 4
        let x2 = -(size.width / 4)
        self.x_positions = [x1, x2]
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(GameScene.didSwipe))
        rightSwipe.direction = .right
        view.addGestureRecognizer(rightSwipe)
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(GameScene.didSwipe))
        leftSwipe.direction = .left
        view.addGestureRecognizer(leftSwipe)
        
        self.scoreLabel = SKLabelNode(fontNamed: "8BIT WONDER")
        self.scoreLabel.text = "SCORE: \(self.score)"
        self.scoreLabel.fontSize = 32
        self.scoreLabel.position = CGPoint(x: x_positions[1], y: -650)
        self.backgroundColor = SKColor.white
        self.scoreLabel.fontColor = SKColor.black
        self.addChild(self.scoreLabel)
        
    }
    
    func createCharsArray(){

        
        self.allChar.removeAll()
        
        let l_red = SKSpriteNode(imageNamed: "l-red")
        let r_red = SKSpriteNode(imageNamed: "r-red")
        let l_black = SKSpriteNode(imageNamed: "l-black")
        let r_black = SKSpriteNode(imageNamed: "r-black")
        
        l_red.name = "l_red"
        r_red.name = "r_red"
        l_black.name = "l_black"
        r_black.name = "r_black"
        
        let temp : [SKSpriteNode] = [l_red, r_red, l_black, r_black]

        for char in temp {
            self.allChar.append(char)
        }
    }
    
    func createChar(){
        let character = self.allChar[self.allChar.count.arc4random]
        nodeArray.append(character)
        character.position = CGPoint(x:self.x_positions[self.x_positions.count.arc4random], y:670)
        character.size = CGSize(width: 193, height: 185)
        
        self.physicsWorld.gravity = CGVector(dx: 0.0, dy: -1.0)
        character.physicsBody = SKPhysicsBody(texture: character.texture!, size: character.size)
        character.alpha = 0.0
        self.addChild(character)

        character.run(SKAction.fadeIn(withDuration: 1.0))
    }
    
    @objc func didSwipe(sender: UISwipeGestureRecognizer) {
        let moveToRight = SKAction.moveBy(x: size.width, y: 0, duration: 0.5)
        let moveToLeft = SKAction.moveBy(x: -(size.width), y: 0, duration: 0.5)
        
        if sender.direction == .right {
            switch self.nodeArray[0].name {
            case "l_red":
                if floor(self.nodeArray[0].position.x) == floor(self.x_positions[0]) {
                    self.nodeArray[0].run(moveToRight)
                    self.score += 1
                }
                else{
                    self.myDelegate?.showDialog(score: self.score)
                    self.pause()
                }
            case "r_red" :
                if floor(self.nodeArray[0].position.x) == floor(self.x_positions[0]) {
                    self.nodeArray[0].run(moveToRight)
                    self.score += 1
                }
                else{
                    self.myDelegate?.showDialog(score: self.score)
                    self.pause()
                }
            case "l_black" :
                self.myDelegate?.showDialog(score: self.score)
                self.pause()
            case "r_black" :
                self.nodeArray[0].run(moveToRight)
                self.score += 1
            default :
                self.myDelegate?.showDialog(score: self.score)
                self.pause()
            }
        }
        else if sender.direction == .left {
            switch self.nodeArray[0].name {
            case "l_red":
                if floor(self.nodeArray[0].position.x) == floor(self.x_positions[1]) {
                    self.nodeArray[0].run(moveToLeft)
                    self.score += 1
                }
                else{
                    self.myDelegate?.showDialog(score: self.score)
                    self.pause()
                }
            case "r_red" :
                if floor(self.nodeArray[0].position.x) == floor(self.x_positions[1]) {
                    self.nodeArray[0].run(moveToLeft)
                    self.score += 1
                }
                else{
                    self.myDelegate?.showDialog(score: self.score)
                    self.pause()
                }
            case "l_black" :
                self.nodeArray[0].run(moveToLeft)
                self.score += 1
            case "r_black" :
                self.myDelegate?.showDialog(score: self.score)
                self.pause()
            default :
                self.myDelegate?.showDialog(score: self.score)
                self.pause()
            }
        }
    }

    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        if lastChar == nil{
            lastChar = currentTime
        }

        if lastChar + 2.0 <= currentTime{
            self.createChar()
            lastChar = currentTime
        }
        
        self.createCharsArray()
        self.scoreLabel.text = "SCORE: \(self.score)"
        
        for (index, _) in self.nodeArray.enumerated() {
            if index > 0{
                if nodeArray[index - 1].position.x <= -188 || nodeArray[index - 1].position.x >= 188{
                    nodeArray.remove(at: index - 1)
//                    nodeArray[index - 1].removeFromParent()
                }
                else if nodeArray[index - 1].position.y <= -670 {
                    self.myDelegate?.showDialog(score: self.score)
                    self.pause()
                }
            }
        }
        
    }
    
    func pause() {
        let wait = SKAction.wait(forDuration: 0)
        let pause = SKAction.run { self.isPaused = true }
        self.run(SKAction.sequence([wait, pause]))
    }
}

extension Int{
    var arc4random: Int{
        if self > 0{
            return Int(arc4random_uniform(UInt32(self)))
        }
        else if self < 0 {
            return -Int(arc4random_uniform(UInt32(self)))
        }
        else {
            return 0
        }
    }
}
