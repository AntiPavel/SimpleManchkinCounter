//
//  Manchkin.swift
//  SimpleManchkinCounter
//
//  Created by Antonov, Pavel on 3/16/18.
//  Copyright © 2018 paul. All rights reserved.
//

import Foundation

final class Manchkin: Player {
    
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
        bonus += 1
    }
    
    func decreaseBonus() {
        bonus -= 1
    }
    
    func setCourse(coursed: Bool) {
        isCoursedNow = coursed
    }
    
    func getStreight() -> Int {
        return streight + level
    }
    
    func isCoursed() -> Bool {
        return isCoursedNow
    }
    
    func getId() -> Int {
        return id
    }
    
    private let id: Int
    private var streight: Int = 0
    private var level: Int = 0
    private var bonus: Int = 0
    private var isCoursedNow: Bool = false
    private var storedName: String = "Player"
}
