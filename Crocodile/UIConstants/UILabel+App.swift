//
//  UILabel+App.swift
//  Crocodile
//
//  Created by Владислав on 17.04.2023.
//

import UIKit

extension UILabel {
    convenience init(text: String = "") {
        self.init()
        self.text = text
        self.font = UIFont.italicSystemFont(ofSize: 38)
        self.textAlignment = .center
        self.adjustsFontSizeToFitWidth = true
        self.minimumScaleFactor = 0.5
    }
    
    convenience init(text: String = "", font: UIFont?) {
        self.init()
        self.text = text
        self.font = font
        self.textAlignment = .center
        self.numberOfLines = 2
        self.adjustsFontSizeToFitWidth = true
    }
}
