//
//  Model.swift
//  Crocodile
//
//  Created by sidzhe on 19.04.2023.
//

import UIKit

class TeamData {
    
    static var shared = TeamData()
    
    var teamArray = [
        TeamModel(name: "Барсики", image: UIImage(named: "cat") ?? UIImage()),
        TeamModel(name: "Стройняшки", image: UIImage(named: "fat") ?? UIImage()),
    ]
    
    var newTeamArray = [
        TeamModel(name: "Ежики", image: UIImage(named: "hedgehog") ?? UIImage()),
        TeamModel(name: "Персики", image: UIImage(named: "peach") ?? UIImage()),
        TeamModel(name: "Пришельцы", image: UIImage(named: "ufo") ?? UIImage()),
        TeamModel(name: "Ковбои", image: UIImage(named: "cowboy") ?? UIImage())
    ]
    
}


