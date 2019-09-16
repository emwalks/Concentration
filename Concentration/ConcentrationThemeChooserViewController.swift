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
    
    //manual segue in code rather than in mainstoryboard
    //still need to add single segue from view controller to view controller
    //here we have a conditional segue - now if we are mid game we dont segue and reset a new game on ipad, we just change theme mid game
    @IBAction func changeTheme(_ sender: Any) {
        if let cvc = splitViewDetailConcrentrationViewController {
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
                cvc.theme = theme
            }
            //this will keep the game going in navigation view if someone changes the theme mid game
            //keeps the game in the heap
        } else if let cvc = lastSeguedToConcentrationViewController {
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
                cvc.theme = theme
            }
            navigationController?.pushViewController(cvc, animated: true)
        } else {
            performSegue(withIdentifier: "Choose Theme", sender: sender)
        }
    }
    

    private var splitViewDetailConcrentrationViewController: ConcentrationViewController? {
        return splitViewController?.viewControllers.last as? ConcentrationViewController
    }
    
    // MARK: - Navigation
    
    private var lastSeguedToConcentrationViewController: ConcentrationViewController?
    
    
    //the sender is the thing causing the segue - in the case the buttons in the stack
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Choose Theme" {
            //because the sender is an Any optional we need to set it to a button then we can use it (cant do sender.currentTitle)
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
                //here we use as? to downcast to use ConcentrationViewController
                if let cvc = segue.destination as? ConcentrationViewController {
                    cvc.theme = theme
                    //keeps the last game as a var in the heap
                    lastSeguedToConcentrationViewController = cvc
                }
            }
        }
    }
}
