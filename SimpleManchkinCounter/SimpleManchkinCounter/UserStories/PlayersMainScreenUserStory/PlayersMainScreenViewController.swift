//
//  PlayersMainScreenViewController.swift
//  SimpleManchkinCounter
//
//  Created by Antonov, Pavel on 3/17/18.
//  Copyright © 2018 paul. All rights reserved.
//

import UIKit

class PlayersMainScreenViewController: UIViewController, TransitionHandler {

    @IBOutlet weak var backButton: UIButton!
    @IBAction func backAction(_ sender: Any) {
        let moduleId = ModuleId(storyboardId: Storyboard.Main.storyboardName,
                                controllerId: Storyboard.Main.startScreenViewController.rawValue,
                                transitionType: .pop)
        self.openModule(with: moduleId) { _ in }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    override func viewWillAppear(_ animated: Bool) {

//            // guard let transitionHandler = transitionHandler as? TransitionHandler else { return }
//            let moduleId = ModuleId(storyboardId: Storyboard.Main.storyboardName,
//                                    controllerId: Storyboard.Main.fightViewController.rawValue,
//                                    transitionType: .push)
//            self.openModule(with: moduleId) { _ in }


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
