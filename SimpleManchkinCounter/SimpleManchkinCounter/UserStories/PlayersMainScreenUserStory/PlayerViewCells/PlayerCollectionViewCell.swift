//
//  PlayerCollectionViewCell.swift
//  SimpleManchkinCounter
//
//  Created by Antonov, Pavel on 3/17/18.
//  Copyright © 2018 paul. All rights reserved.
//

import UIKit

class PlayerCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var cellBaseView: UIView!
    @IBOutlet weak var cellBaseImageView: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var xButton: UIButton!
    @IBOutlet weak var strenghtTitle: UILabel!
    @IBOutlet weak var strenghtBaseView: UIView!
    @IBOutlet weak var strenghtBackgroundImageView: UIImageView!
    @IBOutlet weak var strenghtLabel: UILabel!
    @IBOutlet weak var levelTitle: UILabel!
    @IBOutlet weak var levelBaseView: UIView!
    @IBOutlet weak var levelBackgrondImageView: UIImageView!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var bonusTitle: UILabel!
    @IBOutlet weak var bonusBaseView: UIView!
    @IBOutlet weak var bonusBackgroundImageView: UIImageView!
    @IBOutlet weak var bonusLabel: UILabel!
    @IBOutlet weak var curseButton: UIButton!
    @IBOutlet weak var fightButton: UIButton!
    @IBAction func fightButtonAction(_ sender: Any) {
    }
    @IBAction func curseButtonAction(_ sender: Any) {
    }
    @IBAction func xButtonAction(_ sender: Any) {
    }
    @IBAction func levelUpAction(_ sender: Any) {
    }
    @IBAction func levelDownAction(_ sender: Any) {
    }
    @IBAction func bonusUpAction(_ sender: Any) {
    }
    @IBAction func bonusDownAction(_ sender: Any) {
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
