//
//  Player.swift
//  SimpleManchkinCounter
//
//  Created by Antonov, Pavel on 3/16/18.
//  Copyright © 2018 paul. All rights reserved.
//

import Foundation

protocol  Player {
    
    init(id: Int)
    
    func setName(name: String)
    func getName() -> String
    func getId() -> Int
    func increaseLevel()
    func decreaseLevel()
    func increaseBonus()
    func decreaseBonus()
    func setCourse(coursed: Bool)
    func getStreight() -> Int
    func isCoursed() -> Bool
}
