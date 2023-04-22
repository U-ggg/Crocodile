//
//  Model.swift
//  Crocodile
//
//  Created by sidzhe on 19.04.2023.
//

import UIKit

class TeamData {
    
    static var shared = TeamData()
    
    var textFieldTag = Int()
    
    var teamArray = [
        TeamModel(name: "Барсики", image: UIImage(named: "cat") ?? UIImage()),
        TeamModel(name: "Стройняшки", image: UIImage(named: "fat") ?? UIImage()),
    ]
    
    var avatars = [
        UIImage(named: "hedgehog")!,
        UIImage(named: "peach")!,
        UIImage(named: "ufo")!,
        UIImage(named: "cowboy")!,
        UIImage(named: "cat")!,
        UIImage(named: "fat")!,
        UIImage(named: "ai")!,
        UIImage(named: "doll")!,
        UIImage(named: "eagle")!,
        UIImage(named: "happy")!,
        UIImage(named: "spiderman")!
    ]
    
    var newTeamArray = [
        TeamModel(name: "Ежики", image: UIImage(named: "hedgehog") ?? UIImage()),
        TeamModel(name: "Персики", image: UIImage(named: "peach") ?? UIImage()),
        TeamModel(name: "Пришельцы", image: UIImage(named: "ufo") ?? UIImage()),
        TeamModel(name: "Ковбои", image: UIImage(named: "cowboy") ?? UIImage())
    ]
    
    func addTeam() -> [IndexPath] {
        newTeamArray.shuffle()
        avatars.shuffle()
        newTeamArray[0].image = avatars[0]
        teamArray.append(newTeamArray[0])
        newTeamArray.remove(at: 0)
        let indexPath = [IndexPath(row: TeamData.shared.teamArray.count - 1, section: 0)]
        return indexPath
    }
    
    func checkSameName() -> Bool {
        var array = [String]()
        for i in 0..<teamArray.count {
            array.append(teamArray[i].name)
        }
        if Set(array).count != array.count {
            return false
        }
        return true
    }
}

