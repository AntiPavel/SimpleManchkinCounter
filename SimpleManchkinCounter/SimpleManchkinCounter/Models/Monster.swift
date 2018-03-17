//
//  Monster.swift
//  SimpleManchkinCounter
//
//  Created by Antonov, Pavel on 3/16/18.
//  Copyright © 2018 paul. All rights reserved.
//

import Foundation

final class Monster: Player {
    
    public init(id: Int) {
        self.id = id
    }
    
    func setName(name: String) {
        storedName = name
    }
    
    func getName() -> String {
        return storedName
    }
    
    func increaseLevel() {
        level += 1
    }
    
    func decreaseLevel() {
        level -= 1
    }
    
    func increaseBonus() {
    }
    
    func decreaseBonus() {
    }
    
    func setCourse(coursed: Bool) {
    }
    
    func getStreight() -> Int {
        return bonus + level
    }
    
    func isCursed() -> Bool {
        return isCursedNow
    }
    
    func getId() -> Int {
        return id
    }
    
    private let id: Int
    private var level: Int = 0
    private let bonus: Int = 0
    private let isCursedNow: Bool = false
    private var storedName: String = "Monstr"
}
