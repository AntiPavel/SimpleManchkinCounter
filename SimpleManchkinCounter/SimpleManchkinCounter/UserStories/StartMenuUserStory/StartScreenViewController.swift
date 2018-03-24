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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let stepper = FlipStepper(frame: CGRect(x:20, y:110, width:300, height:270))
        stepper.addTarget(self, action: #selector(stepperValueChanged), for: .valueChanged)
        self.view.addSubview(stepper)

    }
    
    @objc func stepperValueChanged(stepper: FlipStepper) {
        print(stepper.value)
    }
    
    override func viewWillLayoutSubviews() {
        //cardView.center = view.center
    }

}

