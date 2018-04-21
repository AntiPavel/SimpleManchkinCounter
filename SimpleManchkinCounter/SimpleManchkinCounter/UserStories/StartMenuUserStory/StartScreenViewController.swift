//
//  StartScreenViewController.swift
//  SimpleManchkinCounter
//
//  Created by Antonov, Pavel on 3/17/18.
//  Copyright © 2018 paul. All rights reserved.
//

import UIKit


class StartScreenViewController: UIViewController, TransitionHandler {

    @IBAction func startNewGameAction(_ sender: Any) {
        // guard let transitionHandler = transitionHandler as? TransitionHandler else { return }
        let moduleId = ModuleId(storyboardId: Storyboard.Main.storyboardName,
                                controllerId: Storyboard.Main.playersMainScreenViewController.rawValue,
                                transitionType: .push)
        self.openModule(with: moduleId) { _ in }

    }
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLabels()
//        let stepper = FlipStepper(frame: CGRect(x:20, y:110, width:300, height:270))
//        stepper.addTarget(self, action: #selector(stepperValueChanged), for: .valueChanged)
//        self.view.addSubview(stepper)

    }
    
    private func setupLabels() {
        
        let titleStrokeTextAttributes: [NSAttributedStringKey : Any] = [
            NSAttributedStringKey.strokeColor : UIColor.blue,//UIColor(red: 235/256, green: 210/256, blue: 189/256, alpha: 1),
            NSAttributedStringKey.foregroundColor : UIColor(red: 201/256, green: 255/256, blue: 40/256, alpha: 1),
            NSAttributedStringKey.strokeWidth : -2.0
        ]
//        let titlesStrokeTextAttributes: [NSAttributedStringKey : Any] = [
//            NSAttributedStringKey.strokeColor : UIColor.black,
//            NSAttributedStringKey.foregroundColor : UIColor(red: 235/256, green: 210/256, blue: 189/256, alpha: 1),
//            NSAttributedStringKey.strokeWidth : -2.0
//        ]
        
        //        let strenghtStrokeTextAttributes = [NSStrokeColorAttributeName : UIColor(colorLiteralRed: 235/256, green: 210/256, blue: 189/256, alpha: 1), NSForegroundColorAttributeName : UIColor(colorLiteralRed: 142/256, green: 30/256, blue: 44/256, alpha: 1), NSStrokeWidthAttributeName : -2.0, ] as [String : Any]
        //        let titlesStrokeTextAttributes = [NSStrokeColorAttributeName : UIColor.black, NSForegroundColorAttributeName : UIColor(colorLiteralRed: 235/256, green: 210/256, blue: 189/256, alpha: 1), NSStrokeWidthAttributeName : -2.0, ] as [String : Any]
        
//        playersStrenghtLabel.attributedText = NSAttributedString(string: "49", attributes: strenghtStrokeTextAttributes)
//        monstersStrenghtLabel.attributedText = NSAttributedString(string: "87", attributes: strenghtStrokeTextAttributes)
        
        titleLabel.attributedText = NSAttributedString(string: "MANCHKIN COUNTER", attributes: titleStrokeTextAttributes)
//        monstersTitle.attributedText = NSAttributedString(string: "MONSTERS", attributes: titlesStrokeTextAttributes)
        
//        winButton.setTitleColor(UIColor(red: 65/256, green: 110/256, blue: 5/256, alpha: 1), for: .normal)
        
    }
    
    @objc func stepperValueChanged(stepper: FlipStepper) {
        print(stepper.value)
    }
    
    override func viewWillLayoutSubviews() {
        //cardView.center = view.center
    }

}

