//
//  Storyboard.swift
//  SimpleManchkinCounter
//
//  Created by Antonov, Pavel on 3/17/18.
//  Copyright © 2018 paul. All rights reserved.
//

import Foundation
import UIKit

protocol StoryboardSceneType {
    static var storyboardName: String { get }
}

extension StoryboardSceneType {
    static func storyboard() -> UIStoryboard {
        return UIStoryboard(name: self.storyboardName, bundle: nil)
    }
    
    static func initialViewController() -> UIViewController {
        guard let vc = storyboard().instantiateInitialViewController() else {
            fatalError("Failed to instantiate initialViewController for \(self.storyboardName)")
        }
        return vc
    }
}

extension StoryboardSceneType where Self: RawRepresentable, Self.RawValue == String {
    func viewController() -> UIViewController {
        return Self.storyboard().instantiateViewController(withIdentifier: self.rawValue)
    }
    static func viewController(identifier: Self) -> UIViewController {
        return identifier.viewController()
    }
}

protocol StoryboardSegueType: RawRepresentable { }

extension UIViewController {
    func perform<S: StoryboardSegueType>(segue: S, sender: Any? = nil) where S.RawValue == String {
        performSegue(withIdentifier: segue.rawValue, sender: sender)
    }
}

struct Storyboard {
    
    enum Main: String, StoryboardSceneType {
        static let storyboardName = "Main"
        
        static func initialViewController() -> UINavigationController {
            guard let vc = storyboard().instantiateInitialViewController() as? UINavigationController else {
                fatalError("Failed to instantiate initialViewController for \(self.storyboardName)")
            }
            return vc
        }
        
        case startScreenViewController = "StartScreenViewController"
        static func instantiateInfoRegistrationViewController() -> StartScreenViewController {
            guard let vc = Storyboard.Main.startScreenViewController.viewController() as? StartScreenViewController  else {
                fatalError("ViewController 'StartScreenViewController' is not of the expected class StartScreenViewController.")
            }
            return vc
        }
        
        case playersMainScreenViewController = "PlayersMainScreenViewController"
        static func instantiatePlayersMainScreenViewController() -> PlayersMainScreenViewController {
            guard let vc = Storyboard.Main.playersMainScreenViewController.viewController() as? PlayersMainScreenViewController else {
                fatalError("ViewController 'PlayersMainScreenViewController' is not of the expected class PlayersMainScreenViewController.")
            }
            return vc
        }
        
        case fightViewController = "FightViewController"
        static func instantiateFightViewController() -> FightViewController {
            guard let vc = Storyboard.Main.fightViewController.viewController() as? FightViewController else {
                fatalError("ViewController 'FightViewController' is not of the expected class FightViewController.")
            }
            return vc
        }
    }
}
