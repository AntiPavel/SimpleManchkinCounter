//
//  StartScreenPresenter.swift
//  SimpleManchkinCounter
//
//  Created by Antonov, Pavel on 4/21/18.
//  Copyright © 2018 paul. All rights reserved.
//

import Foundation

protocol StartScreenPresenter {
    
    func viewIsReady()
    var view: StartScreenViewController! { get set }
}

class StartScreenPresenterImplementation: StartScreenPresenter {
    
    weak var view: StartScreenViewController!
    
    func viewIsReady() {
        
    }
}
