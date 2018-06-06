//
//  ViewController.swift
//  TipCulculator
//
//  Created by 佐藤亘 on 2018/06/01.
//  Copyright © 2018年 佐藤亘. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var foodBill = 0.00
    private var tipPercentage = 0.00
    private var tipAmount = 0.00

    @IBOutlet weak var billAmountTextField: UITextField!
    @IBOutlet weak var tipAmountLabel: UILabel!
    @IBOutlet weak var tipPecentageTextField: UITextField!
    
    @IBAction func adjustTipSlider(_ sender: UISlider) {
        adjustTipPercentage(sender.value)
    }
    
    @IBAction func calculateTipButton(_ sender: UIButton) {
        calculateTip()
        view.endEditing(true)
    }
    
    
    func calculateTip() {
        if !((billAmountTextField.text?.isEmpty)!) && !((tipPecentageTextField.text?.isEmpty)!){
            foodBill = Double(billAmountTextField.text!)!
            tipPercentage = (Double(tipPecentageTextField.text!)! / 100)
            
            tipAmount = foodBill * tipPercentage
            tipAmountLabel.text = "Tip Amount: $\(tipAmount)"
        }
    }
    
    func adjustTipPercentage(_ value:Float) {
        tipPercentage = (Double(Int(value)) / 100)
        tipPecentageTextField.text = "\(Int(value))"
    }
    

    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view, typically from a nib.
//    }

//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }


}

