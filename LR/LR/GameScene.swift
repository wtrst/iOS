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
    private var mode : String!
    private var isSwipedDown : Bool = false
    weak var myDelegate: DialogDelegate?
    
    override func didMove(to view: SKView) {
        
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(GameScene.didSwipe))
        rightSwipe.direction = .right
        view.addGestureRecognizer(rightSwipe)
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(GameScene.didSwipe))
        leftSwipe.direction = .left
        view.addGestureRecognizer(leftSwipe)
        
        let dowmSwipe = UISwipeGestureRecognizer(target: self, action: #selector(GameScene.didSwipe))
        dowmSwipe.direction = .down
        view.addGestureRecognizer(dowmSwipe)
        
        self.scoreLabel = SKLabelNode(fontNamed: "8BIT WONDER")
        self.scoreLabel.text = "SCORE: \(self.score)"
        self.scoreLabel.fontSize = 32
        self.backgroundColor = SKColor.white
        self.scoreLabel.fontColor = SKColor.black
        
        
        if self.mode == "hard"{
            let x2_1 = ((size.width / 6) * 2) + 20.3
            let x2_2 = -(size.width / 6) * 2 - 0.3
            let x2_3 = (size.width * 0) + 10.3
            
            self.x_positions = [x2_1, x2_2, x2_3]
            
            self.scoreLabel.position = CGPoint(x: 0, y: -650)
            
            let border1 = SKSpriteNode(imageNamed: "centerLine")
            border1.position = CGPoint(x: -112, y: 0)
            border1.size = CGSize(width: border1.size.width, height: border1.size.height * 1.5)
            self.addChild(border1)
            
            let border2 = SKSpriteNode(imageNamed: "centerLine")
            border2.position = CGPoint(x: 172, y: 0)
            border2.size = CGSize(width: border2.size.width, height: border2.size.height * 1.5)
            self.addChild(border2)
        }
        else{
            let x1_1 = size.width / 4
            let x1_2 = -(size.width / 4)
            self.x_positions = [x1_1, x1_2]
            
            self.scoreLabel.position = CGPoint(x: x_positions[1], y: -650)
            
            let border = SKSpriteNode(imageNamed: "centerLine")
            border.position = CGPoint(x: 30, y: 0)
            border.size = CGSize(width: border.size.width, height: border.size.height * 1.5)
            self.addChild(border)
        }
        
        self.addChild(self.scoreLabel)
    }
    
    func setMode(menu: String){
        self.mode = menu
    }
    
    func createCharsArray(){
        self.allChar.removeAll()
        
        let l_red = SKSpriteNode(imageNamed: "l-red")
        let r_red = SKSpriteNode(imageNamed: "r-red")
        let c_red = SKSpriteNode(imageNamed: "c-red")
        let l_black = SKSpriteNode(imageNamed: "l-black")
        let r_black = SKSpriteNode(imageNamed: "r-black")
        let c_black = SKSpriteNode(imageNamed: "c-black")
        
        l_red.name = "l_red"
        r_red.name = "r_red"
        c_red.name = "c_red"
        l_black.name = "l_black"
        r_black.name = "r_black"
        c_black.name = "c_black"
        
        var temp : [SKSpriteNode] = [l_red, r_red, l_black, r_black]
        
        if self.mode == "hard"{
            temp.append(c_red)
            temp.append(c_black)
        }

        for char in temp {
            self.allChar.append(char)
        }
    }
    
    func createChar(){
        let character = self.allChar[self.allChar.count.arc4random]
        nodeArray.append(character)
        character.position = CGPoint(x:self.x_positions[self.x_positions.count.arc4random], y:670)
        character.size = CGSize(width: 193, height: 185)
        if self.mode == "easy" {
            self.physicsWorld.gravity = CGVector(dx: 0.0, dy: -1.0)
        }
        else if self.mode == "normal" || self.mode == "hard" {
            self.physicsWorld.gravity = CGVector(dx: 0.0, dy: -1.5)
        }
        
        character.physicsBody = SKPhysicsBody(texture: character.texture!, size: character.size)
        character.alpha = 0.0
        self.addChild(character)

        character.run(SKAction.fadeIn(withDuration: 1.0))
    }
    
    @objc func didSwipe(sender: UISwipeGestureRecognizer) {
        let moveToRight = SKAction.moveBy(x: size.width, y: 0, duration: 0.5)
        let moveToLeft = SKAction.moveBy(x: -(size.width), y: 0, duration: 0.5)
        let moveToBottom = SKAction.moveBy(x: 0, y: -(size.height), duration: 0.5)
        
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
            case "c_red" :
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
            case "c_black" :
                self.myDelegate?.showDialog(score: self.score)
                self.pause()
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
            case "c_red" :
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
            case "c_black" :
                self.myDelegate?.showDialog(score: self.score)
                self.pause()
            default :
                self.myDelegate?.showDialog(score: self.score)
                self.pause()
            }
        }
        else if sender.direction == .down && self.mode == "hard" {
            switch self.nodeArray[0].name {
            case "l_red":
                if floor(self.nodeArray[0].position.x) == floor(self.x_positions[2]) {
                    self.nodeArray[0].run(moveToBottom)
                    self.score += 1
                    self.isSwipedDown = true
                }
                else{
                    self.myDelegate?.showDialog(score: self.score)
                    self.pause()
                }
            case "r_red" :
                if floor(self.nodeArray[0].position.x) == floor(self.x_positions[2]) {
                    self.nodeArray[0].run(moveToBottom)
                    self.score += 1
                    self.isSwipedDown = true
                }
                else{
                    self.myDelegate?.showDialog(score: self.score)
                    self.pause()
                }
            case "c_red" :
                if floor(self.nodeArray[0].position.x) == floor(self.x_positions[2]) {
                    self.nodeArray[0].run(moveToBottom)
                    self.score += 1
                    self.isSwipedDown = true
                }
                else{
                    self.myDelegate?.showDialog(score: self.score)
                    self.pause()
                }
            case "l_black" :
                self.myDelegate?.showDialog(score: self.score)
                self.pause()
            case "r_black" :
                self.myDelegate?.showDialog(score: self.score)
                self.pause()
            case "c_black" :
                self.nodeArray[0].run(moveToBottom)
                self.score += 1
                self.isSwipedDown = true
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
                if nodeArray[index - 1].position.x <= -300 || nodeArray[index - 1].position.x >= 300 || (nodeArray[index - 1].position.y <= -670 && self.isSwipedDown == true){
                    nodeArray.remove(at: index - 1)
                    self.isSwipedDown = false
//                    nodeArray[index - 1].removeFromParent()
                }
                else if nodeArray[index - 1].position.y <= -670 && self.isSwipedDown == false {
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first as UITouch? {
            let location = touch.location(in: self)
            print(location)
        }
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
