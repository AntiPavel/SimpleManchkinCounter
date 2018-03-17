//
//  PlayerManager.swift
//  SimpleManchkinCounter
//
//  Created by Antonov, Pavel on 3/16/18.
//  Copyright © 2018 paul. All rights reserved.
//

import Foundation

protocol PlayerManager {
    
    func addManchkin()
    func addMonster()
    func removePlayer(id: Int)
    func getMonsters() -> Array<Monster>
    func getManchkins() -> Array<Manchkin>
    func getMonster(id: Int) -> Monster?
    func getManchkin(id: Int) -> Manchkin?
}

final class SimplePlayerManager: PlayerManager {
    
    static let shared: SimplePlayerManager = {
        let instance = SimplePlayerManager()
        if let id = UserDefaults.standard.object(forKey: playerIdKey) as? Int, id != 0 {
            // the id already exist so nothing to do
        } else {
            let uuid = UUID().hashValue
            UserDefaults.standard.set(uuid, forKey: playerIdKey)
        }
        return instance
    }()
    
    func addManchkin() {
        let id: Int = UserDefaults.standard.object(forKey: SimplePlayerManager.getPlayerIdKey()) as? Int ?? Int(arc4random_uniform(99999999))
        UserDefaults.standard.set(id + 1, forKey: SimplePlayerManager.getPlayerIdKey())
        let manchkin = Manchkin(id: id)
        manchkins.append(manchkin)
    }
    
    func addMonster() {
        let id: Int = UserDefaults.standard.object(forKey: SimplePlayerManager.getPlayerIdKey()) as? Int ?? Int(arc4random_uniform(99999999))
        UserDefaults.standard.set(id + 1, forKey: SimplePlayerManager.getPlayerIdKey())
        let monster = Monster(id: id)
        monsters.append(monster)
    }
    
    func removePlayer(id: Int) {
        manchkins = manchkins.filter{ $0.getId() != id }
        monsters = monsters.filter{ $0.getId() != id }
    }
    
    func getMonsters() -> Array<Monster> {
        return monsters
    }
    
    func getManchkins() -> Array<Manchkin> {
        return manchkins
    }
    
    func getMonster(id: Int) -> Monster? {
        let monster = monsters.filter{ $0.getId() == id }
        return monster.first
    }
    
    func getManchkin(id: Int) -> Manchkin? {
        let manchkin = manchkins.filter{ $0.getId() == id }
        return manchkin.first
    }
    
    static private func getPlayerIdKey() -> String {
        return playerIdKey
    }
    
    private var manchkins: Array<Manchkin> = []
    private var monsters: Array<Monster> = []
    static private let playerIdKey = "playerId"
    
}
