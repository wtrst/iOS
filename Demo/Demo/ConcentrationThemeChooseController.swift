//
//  ConcentrationThemeChooseController.swift
//  Demo
//
//  Created by 佐藤亘 on 2018/05/31.
//  Copyright © 2018年 佐藤亘. All rights reserved.
//

import UIKit

class ConcentrationThemeChooseController: NSObject {
    let themes = [
        "Flags":["🇯🇵", "🇨🇦", "🇪🇸", "🇧🇷", "🇨🇱", "🇨🇴", "🇨🇲", "🇺🇸", "🇹🇷", "🇬🇧", "🇮🇹", "🇩🇪"],
        "Cars":["🚗", "🚕", "🚙", "🚌", "🚎", "🏎", "🚓", "🚑", "🚒", "🚐", "🚛", "🚜"],
        "Sports":["⚽️", "🏀", "🏈", "⚾️", "🎾", "🏐", "🏉", "🎱", "🏓", "🏸", "🥊", "🥌"],
        "Animals":["🐅", "🐆", "🦓", "🦍", "🐘", "🦏", "🐪", "🦒", "🐃", "🐂", "🐖", "🦌"],
        "Handsigns":["🙌", "👍", "👎", "👊", "🤞", "✌️", "🤟", "🤘", "☝️", "✋", "🖖", "🤙"],
        "Families":["👪", "👨‍👩‍👧", "👨‍👩‍👧‍👦", "👨‍👩‍👦‍👦", "👨‍👩‍👧‍👧", "👩‍👩‍👦", "👩‍👩‍👧", "👨‍👨‍👦", "👨‍👨‍👧", "👩‍👦", "👨‍👦", "👨‍👧‍👧"]
    ]
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "chooseTheme" {
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName]{
                if let cvc = segue.destination as? ConcentrationViewController {
                    cvc.theme = theme
                }
            }
        }
    }
}
