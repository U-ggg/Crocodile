//
//  File.swift
//  Crocodile
//
//  Created by sidzhe on 17.04.2023.
//

import UIKit

struct TeamModel {
    var name: String
    var image: UIImage
    var score = 0
    
    mutating func addScore() {
        score += 1
    }
    
    mutating func nullScore() {
        score = 0
    }
}
