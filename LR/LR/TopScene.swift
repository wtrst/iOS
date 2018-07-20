//
//  TopScene.swift
//  LR
//
//  Created by 佐藤亘 on 2018/07/03.
//  Copyright © 2018年 佐藤亘. All rights reserved.
//

import SpriteKit
import GameplayKit

protocol MenuDelegate: NSObjectProtocol {
    func setParamForSegue(param: String)
}

class TopScene: SKScene {
    weak var myDelegate: MenuDelegate?
    
    override func didMove(to view: SKView) {
        let logo = SKSpriteNode(imageNamed: "logo")
        logo.position = CGPoint(x:0, y:300)
        logo.size = CGSize(width: 400, height: 400)
        self.addChild(logo)
        
        let easy = SKSpriteNode(imageNamed: "easy")
        easy.position = CGPoint(x:0, y:-100)
        easy.zPosition = 1
        easy.size = CGSize(width: easy.size.width * 0.7, height: easy.size.height * 0.7)
        easy.name = "easy"
        self.addChild(easy)
        
        let normal = SKSpriteNode(imageNamed: "normal")
        normal.position = CGPoint(x:0, y:-250)
        normal.zPosition = 1
        normal.size = CGSize(width: normal.size.width * 0.7, height: normal.size.height * 0.7)
        normal.name = "normal"
        self.addChild(normal)
        
        let hard = SKSpriteNode(imageNamed: "hard")
        hard.position = CGPoint(x:0, y:-400)
        hard.zPosition = 1
        hard.size = CGSize(width: hard.size.width * 0.7, height: hard.size.height * 0.7)
        hard.name = "hard"
        self.addChild(hard)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first as UITouch? {
            let location = touch.location(in: self)
            if self.atPoint(location).name == "easy" {
                self.myDelegate?.setParamForSegue(param: "easy")
                self.view?.window?.rootViewController?.performSegue(withIdentifier: "presentGame", sender: nil)
            }
            else if self.atPoint(location).name == "normal" {
                self.myDelegate?.setParamForSegue(param: "normal")
                self.view?.window?.rootViewController?.performSegue(withIdentifier: "presentGame", sender: nil)
            }
            else if self.atPoint(location).name == "hard" {
                self.myDelegate?.setParamForSegue(param: "hard")
                self.view?.window?.rootViewController?.performSegue(withIdentifier: "presentGame", sender: nil)
            }
            else{
                print("nothing")
            }
        }
    }

}
