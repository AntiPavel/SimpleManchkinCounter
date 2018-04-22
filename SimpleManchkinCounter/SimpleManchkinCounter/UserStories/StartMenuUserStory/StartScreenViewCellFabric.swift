//
//  StartScreenViewCellFabric.swift
//  SimpleManchkinCounter
//
//  Created by Antonov, Pavel on 4/21/18.
//  Copyright © 2018 paul. All rights reserved.
//

import Foundation

protocol StartScreenViewCellFabric {
    func viewModels(storedManchkins: Array<Manchkin>?) -> [CellViewModel]
}

class StartScreenViewCellFabricImplementation: StartScreenViewCellFabric {
    
    func viewModels(storedManchkins: Array<Manchkin>?) -> [CellViewModel] {
        let newPlayerCell = NewPlayerCellViewModel(title: "NEW PLAYER...", frameBackgroundViewColor: .black, topBackgroundViewColor: .white)
        var models: [CellViewModel] = [newPlayerCell]
        if let manchkins = storedManchkins, manchkins.count > 0 {
            for manchkin in manchkins {
                let manchkinCell = StoredPlayerViewCellModel(title: manchkin.storedName, frameBackgroundViewColor: .black, topBackgroundViewColor: menuColor)
                models.append(manchkinCell)
            }
        }
        let manchkinCell = StoredPlayerViewCellModel(title: "stored name", frameBackgroundViewColor: .black, topBackgroundViewColor: menuColor)
        models.append(manchkinCell)
        return models
    }
}
