//
//  NewPlayerViewCell.swift
//  SimpleManchkinCounter
//
//  Created by Antonov, Pavel on 4/21/18.
//  Copyright © 2018 paul. All rights reserved.
//

import UIKit

final class NewPlayerViewCell: UITableViewCell, ConfigurableCell {


    @IBOutlet weak var frameBackgroundView: UIView!
    @IBOutlet weak var topBackgroundView: UIView!
    @IBOutlet weak var nameTextField: UITextField!
    static var height: CGFloat = 40
    
    var textFieldReturnAction : ((UITableViewCell) -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    @IBAction func nameTextFieldIAction(_ sender: Any) {
    }
    
    private func setup() {
        nameTextField.delegate = self
        frameBackgroundView.layer.cornerRadius = 8
        topBackgroundView.layer.cornerRadius = 8
//        frameBackgroundView.layer.shadowOffset = CGSize(width: 0, height: 3)
//        frameBackgroundView.layer.shadowRadius = 3
//        frameBackgroundView.layer.shadowOpacity = 0.3
//        frameBackgroundView.layer.shadowPath = UIBezierPath(roundedRect: frameBackgroundView.bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 8, height: 8)).cgPath
//        frameBackgroundView.layer.shouldRasterize = true
//        frameBackgroundView.layer.rasterizationScale = UIScreen.main.scale
    }
    
    func configure(with viewModel: CellViewModel) {
        
        if let viewModel = viewModel as? NewPlayerCellViewModel {
            nameTextField.text = viewModel.title
            nameTextField.placeholder = viewModel.title
            frameBackgroundView.backgroundColor = UIColor(red: 74/256, green: 74/256, blue: 74/256, alpha: 1)//viewModel.frameBackgroundViewColor
            topBackgroundView.backgroundColor = viewModel.topBackgroundViewColor
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        logD("NewPlayerViewCell", message: "setSelected", logLevel: .verbose)
        // Configure the view for the selected state
    }
    
}

extension NewPlayerViewCell: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        logD("NewPlayerViewCell", message: "textField.text: \(textField.text ?? " ")", logLevel: .verbose)
        guard let text = textField.text, !text.isEmpty else {
            textField.text = "NEXT PLAYER..."
            return textField.resignFirstResponder()
        }
        textFieldReturnAction?(self)
        return textField.resignFirstResponder()
    }

}
