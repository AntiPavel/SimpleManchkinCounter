//
//  StoredPlayerViewCellModel.swift
//  SimpleManchkinCounter
//
//  Created by Antonov, Pavel on 4/22/18.
//  Copyright © 2018 paul. All rights reserved.
//

import Foundation
import UIKit

struct StoredPlayerViewCellModel: CellViewModel {
    static let associatedCell: ConfigurableCell.Type = StoredPlayerViewCell.self
    
    let title: String
    let frameBackgroundViewColor: UIColor
    let topBackgroundViewColor: UIColor
}
