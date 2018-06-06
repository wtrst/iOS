//
//  ViewController.swift
//  DemoPlayingCard
//
//  Created by 佐藤亘 on 2018/05/28.
//  Copyright © 2018年 佐藤亘. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        for _ in 1...15 {
            if let card = deck.drawCards(){
                print("\(card)")
            }
        }
    }



}

