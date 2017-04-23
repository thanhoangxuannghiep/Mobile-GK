//
//  RadioButton.swift
//  1542248-1542290-1542293
//
//  Created by Than Hoang Xuan Nghiep on 4/19/17.
//  Copyright © 2017 Than Hoang Xuan Nghiep. All rights reserved.
//

import UIKit

class RadioButton: UIButton {
    var alternateButton: Array<RadioButton>?
    override func awakeFromNib() {
        self.backgroundColor = .clear
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 2.0
        self.layer.masksToBounds = true
    }
    func unselectAlternateButtons(){
        if alternateButton != nil{
            self.isSelected = true
            for aButton: RadioButton in alternateButton!{
                aButton.isSelected = false
            }
        }else{
            toggleButton()
        }
    }
    func toggleButton(){
        self.isSelected = false
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        unselectAlternateButtons()
        self.touchesBegan(touches, with: event)
    }
    override var isSelected: Bool{
        didSet{
            if isSelected {
                self.layer.borderColor = UIColor.black.cgColor
            } else {
                self.layer.borderColor = UIColor.yellow.cgColor
            }
        }
    }
}
