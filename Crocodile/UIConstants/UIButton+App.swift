//
//  UIButton+App.swift
//  Crocodile
//
//  Created by Владислав on 17.04.2023.
//

import UIKit

class OptionsButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(text: String, color: UIColor) {
        self.init(type: .system)
        setTitle(text, for: .normal)
        backgroundColor = color.self    
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        tintColor = .white
        titleLabel?.font = UIFont.systemFont(ofSize: 17)
        layer.cornerRadius = 10
    }
}
