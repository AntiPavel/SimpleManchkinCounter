//
//  TransitionHandler.swift
//  SimpleManchkinCounter
//
//  Created by Antonov, Pavel on 3/17/18.
//  Copyright © 2018 paul. All rights reserved.
//

import Foundation
import UIKit

enum TransitionType {
    case modal
    case push
    case pop
}

struct ModuleId {
    var storyboardId: String?
    var controllerId: String?
    var transitionType: TransitionType
    
    init(storyboardId: String? = nil,
         controllerId: String? = nil,
         transitionType: TransitionType = .push) {
        self.storyboardId = storyboardId
        self.controllerId = controllerId
        self.transitionType = transitionType
    }
}

protocol ModuleConfiguration {
    
}

protocol TransitionHandler {
    func openModule(with moduleId: ModuleId, completion: @escaping (ModuleConfigurable) -> ())
    func closeModule()
}

extension TransitionHandler where Self: UIViewController {
    
    func openModule(with moduleId: ModuleId, completion: @escaping (ModuleConfigurable) -> ()) {
        switch moduleId.transitionType {
        case .modal:
            if let newViewController = createViewController(with: moduleId) {
                configureModule(newViewController, completion: completion)
                present(newViewController, animated: true, completion: nil)
            }
            
        case .push:
            if let navigationController = self.navigationController,
                let newViewController = createViewController(with: moduleId) {
                configureModule(newViewController, completion: completion)
                navigationController.pushLikeModal(viewController: newViewController)
            }
            
        case .pop:
            if let navigationController = self.navigationController {
                navigationController.popLikeBackModal()
            }
        }
    }
    
    private func createViewController(with moduleId: ModuleId) -> UIViewController? {
        var destinationViewController: UIViewController?
        
        if let storyboardId = moduleId.storyboardId {
            let storyboard = UIStoryboard(name: storyboardId, bundle: nil)
            if let controllerId = moduleId.controllerId {
                destinationViewController = storyboard.instantiateViewController(withIdentifier: controllerId)
            } else {
                destinationViewController = storyboard.instantiateInitialViewController()
            }
        } else {
            if let controllerId = moduleId.controllerId {
                destinationViewController = storyboard?.instantiateViewController(withIdentifier: controllerId)
            } else {
                destinationViewController = storyboard?.instantiateInitialViewController()
            }
        }
        return destinationViewController
    }
    
    func configureModule(_ viewController: UIViewController, completion: @escaping (ModuleConfigurable) -> ()) {
        if let provider = viewController as? ModuleConfigurableProvider,
            let configurable = provider.configurable {
            completion(configurable)
        }
    }
    
    func closeModule() {
        if let navigationController = self.navigationController {
            navigationController.popViewController(animated: true)
        } else {
            dismiss(animated: true, completion: nil)
        }
    }
}
