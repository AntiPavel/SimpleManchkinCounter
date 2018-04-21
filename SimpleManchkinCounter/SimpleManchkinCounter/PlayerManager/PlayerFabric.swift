//
//  PlayerFabric.swift
//  SimpleManchkinCounter
//
//  Created by Antonov, Pavel on 4/21/18.
//  Copyright © 2018 paul. All rights reserved.
//

import Foundation

protocol PlayerFabric {
    func getManchkin() -> Manchkin
    func getMonster() -> Monster
}

class SimplePlayerFabric: PlayerFabric {
    
    func getManchkin() -> Manchkin {
        let id: Int = UserDefaults.standard.object(forKey: playerIdBaseKey) as? Int ?? Int(arc4random_uniform(99999999))
        UserDefaults.standard.set(id + 1, forKey: playerIdBaseKey)
        let manchkin = Manchkin(id: id)
        return manchkin
    }
    
    func getMonster() -> Monster {
        let id: Int = UserDefaults.standard.object(forKey: playerIdBaseKey) as? Int ?? Int(arc4random_uniform(99999999))
        UserDefaults.standard.set(id + 1, forKey: playerIdBaseKey)
        let monster = Monster(id: id)
        return monster
    }
}

