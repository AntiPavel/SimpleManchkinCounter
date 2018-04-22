//
//  ConfigurableCell.swift
//  SimpleManchkinCounter
//
//  Created by Antonov, Pavel on 4/21/18.
//  Copyright © 2018 paul. All rights reserved.
//

import Foundation
import UIKit


protocol ConfigurableCell {
    
    static var identifier: String { get }
    
    func configure(with viewModel: CellViewModel)
}

extension ConfigurableCell {
    static var identifier: String {
        return String(describing: self)
    }
}

protocol ConfigurableStaticHeightCell: ConfigurableCell {
    static var cellHeight: CGFloat { get }
}

protocol CellViewModel {
    static var associatedCell: ConfigurableCell.Type { get }
}
