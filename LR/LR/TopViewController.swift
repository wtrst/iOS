//
//  TopViewController.swift
//  LR
//
//  Created by 佐藤亘 on 2018/07/03.
//  Copyright © 2018年 佐藤亘. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class TopViewController: UIViewController, MenuDelegate{
    
    var menu : String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = TopScene(fileNamed: "TopScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                scene.myDelegate = self
                // Present the scene
                view.presentScene(scene)
            }

            view.ignoresSiblingOrder = true
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }
    
    func setParamForSegue(param: String){
        self.menu = param
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller:GameViewController = segue.destination as! GameViewController
        controller.menu = self.menu
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
