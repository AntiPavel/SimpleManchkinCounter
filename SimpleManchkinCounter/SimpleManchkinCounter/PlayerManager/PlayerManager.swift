//
//  PlayerManager.swift
//  SimpleManchkinCounter
//
//  Created by Antonov, Pavel on 3/16/18.
//  Copyright © 2018 paul. All rights reserved.
//

import Foundation

let playerIdBaseKey = "playerIdBase"
let storedPlayers = "storedPlayers"

protocol PlayerManager {
    
    func addNewManchkin()
    func addManchkin(name: String)
    func addMonster()
    func clonePlayer(id: Int) -> Player?
    func removePlayer(id: Int)
    func getMonsters() -> Array<Monster>
    func getManchkins() -> Array<Manchkin>
    func getMonster(id: Int) -> Monster?
    func getManchkin(id: Int) -> Manchkin?
    func setName(name: String, id: Int) -> Bool
    func getName(id: Int) -> String?
    func increasePlayerLevel(_ n: Int, id: Int) -> Bool
    func decreasePlayerLevel(_ n: Int, id: Int) -> Bool
    func increaseManchkinBonus(_ n: Int, id: Int) -> Bool
    func decreaseManchkinBonus(_ n: Int, id: Int) -> Bool
    func changeCourseState(id: Int) -> Bool
    func getStreight(id: Int) -> Int?
    func isCursed(id: Int) -> Bool
    func getStoredManchkins() -> Array<Manchkin>
    func removeStoredManchkin(name: String)

}

final class SimplePlayerManager: PlayerManager {
    
    static let shared: SimplePlayerManager = {
        let instance = SimplePlayerManager()
        instance.setup()
        return instance
    }()
    
    private func setup() {
        createAndStoreIdBaseIfNeed()
        storedManchkins = getStoredManchkins()
    }
    
    func addNewManchkin() {
        manchkins.append(playerFabric.getManchkin())
    }
    
    func addManchkin(name: String) {
        let newManchkin = playerFabric.getManchkin()
        manchkins.append(newManchkin)
    }
    
    func addMonster() {
        monsters.append(playerFabric.getMonster())
    }
    
    func clonePlayer(id: Int) -> Player? {
        guard let player = getPlayer(id: id) else { return nil }
        var clone = player.clone()
        let newPlayerWithNewId = playerFabric.getManchkin()
        clone.id = newPlayerWithNewId.id
        return clone
    }
    
    func removePlayer(id: Int) {
        manchkins = manchkins.filter{ $0.id != id }
        monsters = monsters.filter{ $0.id != id }
    }
    
    func getMonsters() -> Array<Monster> {
        return monsters
    }
    
    func getManchkins() -> Array<Manchkin> {
        return manchkins
    }
    
    func getMonster(id: Int) -> Monster? {
        let monster = monsters.filter{ $0.id == id }
        return monster.first
    }
    
    func getManchkin(id: Int) -> Manchkin? {
        let manchkin = manchkins.filter{ $0.id == id }
        return manchkin.first
    }
    
    func setName(name: String, id: Int) -> Bool {
        guard let manchkin = getManchkin(id: id) else { return false }
        manchkin.storedName = name
        removeStoredManchkin(name: manchkin.storedName)
        storedManchkins.append(manchkin)
        return true
    }
    
    func getName(id: Int) -> String? {
        guard let manchkin = getManchkin(id: id) else { return nil }
        return manchkin.storedName
    }
    
    func increasePlayerLevel(_ n: Int, id: Int) -> Bool  {
        guard var player = getPlayer(id: id) else { return false }
        player.level += n
        return true
    }
    
    func decreasePlayerLevel(_ n: Int, id: Int) -> Bool  {
        guard var player = getPlayer(id: id) else { return false }
        player.level -= n
        return true
    }
    
    func increaseManchkinBonus(_ n: Int, id: Int) -> Bool  {
        guard let manchkin = getManchkin(id: id) else { return false }
        manchkin.bonus += n
        return true
    }
    
    func decreaseManchkinBonus(_ n: Int, id: Int) -> Bool  {
        guard let manchkin = getManchkin(id: id) else { return false }
        manchkin.bonus -= n
        return true
    }
    
//    func increaseManchkinLevel(_ n: Int, id: Int) -> Bool  {
//        guard let manchkin = getManchkin(id: id) else { return false }
//        manchkin.level += n
//    }
//
//    func decreaseManchkinLevel(_ n: Int, id: Int) -> Bool  {
//        guard let manchkin = getManchkin(id: id) else { return false }
//        manchkin.level -= n
//    }
//
//    func increaseMonsterLevel(_ n: Int, id: Int) -> Bool  {
//        guard let monster = getMonster(id: id) else { return false }
//        monster.level += n
//    }
//
//    func decreaseMonsterLevel(_ n: Int, id: Int) -> Bool  {
//        guard let monster = getMonster(id: id) else { return false }
//        monster.level -= n
//    }

    
    func changeCourseState(id: Int) -> Bool {
        guard let manchkin = getManchkin(id: id) else { return false }
        manchkin.isCursedNow = !manchkin.isCursedNow
        return true
    }
    
    func getStreight(id: Int) -> Int?  {
        guard let player = getPlayer(id: id) else { return nil }
        return player.streight
    }
    
    func isCursed(id: Int) -> Bool {
        guard let manchkin = getManchkin(id: id) else { return false }
        return manchkin.isCursedNow
    }
    
    func getStoredManchkins() -> Array<Manchkin> {
        guard let array = UserDefaults.standard.array(forKey: storedPlayers) as? Array<[String: Any]>, array.count > 0 else {
            return [Manchkin]()
        }
        let manchkins = array.flatMap(Manchkin.init(dict:))
        return manchkins
    }
    
    func removeStoredManchkin(name: String) {
        storedManchkins = storedManchkins.filter{ $0.storedName != name }
    }
    
    private func getPlayer(id: Int) -> Player? {
        if  let manchkin = getManchkin(id: id) {
            return manchkin
        }
        if let monster = getMonster(id: id) {
            return monster
        }
        return nil
    }
    
    private func getStoredManchkin(name: String) -> Manchkin? {
        let manchkin = storedManchkins.filter{ $0.storedName == name }
        return manchkin.first
    }
    
    private func createAndStoreIdBaseIfNeed() {
        guard let id = UserDefaults.standard.object(forKey: playerIdBaseKey) as? Int, id != 0 else {
            let uuid = UUID().hashValue
            UserDefaults.standard.set(uuid, forKey: playerIdBaseKey)
            return
        }
        // the base id already exist so nothing to do
    }
    
    private var manchkins: Array<Manchkin> = []
    private var monsters: Array<Monster> = []
    
    private var playerFabric: PlayerFabric = SimplePlayerFabric()
    private var storedManchkins: Array<Manchkin>! {
        didSet {
            UserDefaults.standard.setValue(storedManchkins, forKey: storedPlayers)
        }
    }
}
