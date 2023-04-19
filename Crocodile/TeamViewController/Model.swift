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
        TeamModel(name: "Барсики", image: UIImage(named: "cat")!),
        TeamModel(name: "Стройняшки", image: UIImage(named: "fat")!)
    ]
    
    var newTeamArray = [
        TeamModel(name: "Ежики", image: UIImage(named: "hedgehog")!),
        TeamModel(name: "Персики", image: UIImage(named: "peach")!),
        TeamModel(name: "Пришельцы", image: UIImage(named: "ufo")!),
        TeamModel(name: "Ковбои", image: UIImage(named: "cowboy")!)
    ]
    
}


