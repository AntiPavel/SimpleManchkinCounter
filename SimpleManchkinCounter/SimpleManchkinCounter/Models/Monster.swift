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
    
    func clone() -> Player {
        let clone = Monster(id: id)
        clone.level = level
        return clone
    }
    
    var id: Int
    var level: Int = 0
    var streight: Int {
        get { return level }
    }
}
