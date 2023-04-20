//
//  Model.swift
//  Crocodile
//
//  Created by sidzhe on 19.04.2023.
//

import UIKit

class TeamData {
    
    static var shared = TeamData()
    
    var removeAnimation = Int()
    
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
    
    func checkName(textField: UITextField) {
        switch textField.tag {
        case 0:
            teamArray[0].name = textField.text ?? "Error"
        case 1:
            teamArray[1].name = textField.text ?? "Error"
        case 2:
            teamArray[2].name = textField.text ?? "Error"
        case 3:
            teamArray[3].name = textField.text ?? "Error"
        case 4:
            teamArray[4].name = textField.text ?? "Error"
        default:
            teamArray[5].name = textField.text ?? "Error"
        }
    }
    
    func editingAgree() {
        
    }
    
    func addTeam() {
        if teamArray.count < 6 {
            newTeamArray.shuffle()
            teamArray.append(TeamData.shared.newTeamArray[0])
            newTeamArray.remove(at: 0)
        }
    }
}

