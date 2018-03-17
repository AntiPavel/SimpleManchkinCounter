//
//  ModuleConfigurableProvider.swift
//  SimpleManchkinCounter
//
//  Created by Antonov, Pavel on 3/17/18.
//  Copyright © 2018 paul. All rights reserved.
//

import Foundation

protocol ModuleConfigurableProvider {
    var configurable: ModuleConfigurable? { get }
}
