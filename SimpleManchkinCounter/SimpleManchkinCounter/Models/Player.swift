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
    func clone() -> Player
    
    var id: Int { get set }
    var streight: Int { get }
    var level: Int { get set }
}
