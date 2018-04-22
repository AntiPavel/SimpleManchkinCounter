//
//  StartScreenViewController.swift
//  SimpleManchkinCounter
//
//  Created by Antonov, Pavel on 3/17/18.
//  Copyright © 2018 paul. All rights reserved.
//

import UIKit

protocol StartScreenViewControllerProtocol {
    
}


class StartScreenViewController: UIViewController, TransitionHandler, StartScreenViewControllerProtocol {

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
    @IBOutlet weak var tableViewWidthConstraint: NSLayoutConstraint!
    
    var presenter: StartScreenPresenter!
    var viewModels: [CellViewModel]!
    var factory: StartScreenViewCellFabric!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = StartScreenPresenterImplementation()
        presenter.view = self
        presenter.viewIsReady()
        setup()
//        let stepper = FlipStepper(frame: CGRect(x:20, y:110, width:300, height:270))
//        stepper.addTarget(self, action: #selector(stepperValueChanged), for: .valueChanged)
//        self.view.addSubview(stepper)
    }
    
    private func setup() {
        setupLabels()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "StoredPlayerViewCell", bundle: nil), forCellReuseIdentifier: "StoredPlayerViewCell")
        tableView.register(UINib(nibName: "NewPlayerViewCell", bundle: nil), forCellReuseIdentifier: "NewPlayerViewCell")
        factory = StartScreenViewCellFabricImplementation()
        
    }
    
    private func setupLabels() {
        let titleStrokeTextAttributes: [NSAttributedStringKey : Any] = [
            NSAttributedStringKey.strokeColor : UIColor.blue,
            NSAttributedStringKey.foregroundColor : menuColor,
            NSAttributedStringKey.strokeWidth : -2.0
        ]
        titleLabel.attributedText = NSAttributedString(string: "MANCHKIN COUNTER", attributes: titleStrokeTextAttributes)
    }
    
    private func update() {
        let playerManager = SimplePlayerManager.shared
        viewModels = factory.viewModels(storedManchkins: playerManager.getStoredManchkins())
        
    }
    
    override func viewWillLayoutSubviews() {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        update()
    }

}

extension StartScreenViewController:  UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let viewModel = viewModels[indexPath.row]
        let viewModelType = type(of: viewModel)
        
        let cellIdentifier = viewModelType.associatedCell.identifier
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! ConfigurableCell
        
        cell.configure(with: viewModel)
        
        return cell as! UITableViewCell
    }
}

extension StartScreenViewController: UITableViewDelegate {
    
}


