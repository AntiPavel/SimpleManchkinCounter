//
//  ModuleConfigurable.swift
//  SimpleManchkinCounter
//
//  Created by Antonov, Pavel on 3/17/18.
//  Copyright © 2018 paul. All rights reserved.
//

import Foundation

protocol ModuleConfigurable {
    var config: ModuleConfiguration? { get }
    func configure(with configuration: ModuleConfiguration)
}
