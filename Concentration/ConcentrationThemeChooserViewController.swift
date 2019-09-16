//
//  ConcentrationThemeChooserViewController.swift
//  Concentration
//
//  Created by Emma Walker - TVandMobile Platforms - Core Engineering on 13/09/2019.
//  Copyright © 2019 Emma Walker - TVandMobile Platforms - Core Engineering. All rights reserved.
//

import UIKit

class ConcentrationThemeChooserViewController: UIViewController {
    
    let themes = [
        "Halloween":"👻🎃🦇😈🤡☠️🧙‍♀️👹",
        
        "Animals":"🦁🐸🐝🦋🐙🦈🐻🐞",
        
        "Christmas":"⛄️🥃🎄🎅🏻🎁🦌⛷🦃",
        
        "Nature":"🌈🌵🍄🌸☀️❄️🍁🐚",
        
        "Flags":"🇮🇪🇬🇧🇳🇴🇨🇭🇫🇷🇮🇳🇪🇸🇧🇬",
        
        "Food":"🍏🍊🍓🍋🍉🍇🍍🥕",
    ]
    
    // MARK: - Navigation
    
    //the sender is the thing causing the segue - in the case the buttons in the stack
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Choose Theme" {
            //because the sender is an Any optional we need to set it to a button then we can use it (cant do sender.currentTitle)
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
                //here we use as? to downcast to use ConcentrationViewController
                if let cvc = segue.destination as? ConcentrationViewController {
                    cvc.theme = theme
                }
            }
        }
    }
}
