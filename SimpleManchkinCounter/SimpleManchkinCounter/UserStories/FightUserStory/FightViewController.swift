//
//  FightViewController.swift
//  SimpleManchkinCounter
//
//  Created by paul on 15/03/2018.
//  Copyright © 2018 paul. All rights reserved.
//

import UIKit

class FightViewController: UIViewController, TransitionHandler {

    @IBOutlet weak var playersStrenghtLabel: UILabel!
    @IBOutlet weak var monstersStrenghtLabel: UILabel!
    
    @IBOutlet weak var playersTitle: UILabel!
    @IBOutlet weak var monstersTitle: UILabel!
    
    @IBOutlet weak var winButton: UIButton!
    @IBAction func winButtonAction(_ sender: Any) {
            let moduleId = ModuleId(storyboardId: Storyboard.Main.storyboardName,
                                    controllerId: Storyboard.Main.startScreenViewController.rawValue,
                                    transitionType: .pop)
            self.openModule(with: moduleId) { _ in }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLabels()

        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    private func setupLabels() {
        
         let strenghtStrokeTextAttributes: [NSAttributedString.Key : Any] = [
           NSAttributedString.Key.strokeColor : UIColor(red: 235/256, green: 210/256, blue: 189/256, alpha: 1),
           NSAttributedString.Key.foregroundColor : UIColor(red: 142/256, green: 30/256, blue: 44/256, alpha: 1),
            NSAttributedString.Key.strokeWidth : -2.0
           ]
        let titlesStrokeTextAttributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.strokeColor : UIColor.black,
            NSAttributedString.Key.foregroundColor : UIColor(red: 235/256, green: 210/256, blue: 189/256, alpha: 1),
            NSAttributedString.Key.strokeWidth : -2.0
        ]
        
//        let strenghtStrokeTextAttributes = [NSStrokeColorAttributeName : UIColor(colorLiteralRed: 235/256, green: 210/256, blue: 189/256, alpha: 1), NSForegroundColorAttributeName : UIColor(colorLiteralRed: 142/256, green: 30/256, blue: 44/256, alpha: 1), NSStrokeWidthAttributeName : -2.0, ] as [String : Any]
//        let titlesStrokeTextAttributes = [NSStrokeColorAttributeName : UIColor.black, NSForegroundColorAttributeName : UIColor(colorLiteralRed: 235/256, green: 210/256, blue: 189/256, alpha: 1), NSStrokeWidthAttributeName : -2.0, ] as [String : Any]
        
        playersStrenghtLabel.attributedText = NSAttributedString(string: "49", attributes: strenghtStrokeTextAttributes)
        monstersStrenghtLabel.attributedText = NSAttributedString(string: "87", attributes: strenghtStrokeTextAttributes)
        
        playersTitle.attributedText = NSAttributedString(string: "PLAYERS", attributes: titlesStrokeTextAttributes)
        monstersTitle.attributedText = NSAttributedString(string: "MONSTERS", attributes: titlesStrokeTextAttributes)
        
        winButton.setTitleColor(UIColor(red: 65/256, green: 110/256, blue: 5/256, alpha: 1), for: .normal)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

