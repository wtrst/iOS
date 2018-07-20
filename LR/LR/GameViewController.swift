//
//  GameViewController.swift
//  LR
//
//  Created by 佐藤亘 on 2018/06/13.
//  Copyright © 2018年 佐藤亘. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController, DialogDelegate{
    
    var menu : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = GameScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                scene.myDelegate = self
                scene.setMode(menu: self.menu)
                // Present the scene
                view.presentScene(scene)
            }

            view.ignoresSiblingOrder = true
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }
    
    func showDialog(score : Int){
        let alertController = UIAlertController(title: "SCORE: \(score)", message: "", preferredStyle: UIAlertControllerStyle.alert)
        let top = UIAlertAction(title: "TOP", style: UIAlertActionStyle.default){ (action: UIAlertAction) in
            self.dismiss(animated: true, completion: nil)
        }
        
        let playAgain = UIAlertAction(title: "PLAY AGAIN", style: UIAlertActionStyle.default){ (action: UIAlertAction) in
            self.viewDidLoad()
        }
        
        alertController.addAction(top)
        alertController.addAction(playAgain)
        
        present(alertController,animated: true,completion: nil)
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
