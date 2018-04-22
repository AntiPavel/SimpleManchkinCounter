//
//  NewPlayerCellViewModel.swift
//  SimpleManchkinCounter
//
//  Created by Antonov, Pavel on 4/21/18.
//  Copyright © 2018 paul. All rights reserved.
//

import Foundation
import UIKit

struct NewPlayerCellViewModel: CellViewModel {
    static let associatedCell: ConfigurableCell.Type = NewPlayerViewCell.self
    
    let title: String
    let frameBackgroundViewColor: UIColor
    let topBackgroundViewColor: UIColor
}
