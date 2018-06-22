//
//  ViewController.swift
//  MyScrollView
//
//  Created by 佐藤亘 on 2018/06/06.
//  Copyright © 2018年 佐藤亘. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var secondUIView: UIView!
    
    override func viewDidAppear(_ animated: Bool) {
        secondUIView.frame = CGRect(x: 0, y: -100, width: 375, height:667)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

