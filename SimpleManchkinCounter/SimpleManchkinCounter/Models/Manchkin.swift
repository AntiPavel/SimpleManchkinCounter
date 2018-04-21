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
    
    init?(dict: [String : Any]) {
        guard   let storedName = dict["name"] as? String,
                let id = dict["id"] as? Int else {
            return nil
        }
        self.storedName = storedName
        self.id = id
    }
    
    func clone() -> Player {
        let clone = Manchkin(id: id)
        clone.bonus = bonus
        clone.level = level
        clone.storedName = "clone \(storedName)"
        clone.isCursedNow = isCursedNow
        return clone
    }
    
    var id: Int
    var level: Int = 1 {
        didSet {
            if level < 1 { level = 1 }
        }
    }
    var streight: Int {
        get { return level + bonus }
    }
    var bonus: Int = 0
    var isCursedNow: Bool = false
    var storedName: String = "Player"
}
