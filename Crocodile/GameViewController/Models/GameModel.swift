//
//  GameModel.swift
//  Crocodile
//
//  Created by Владислав on 18.04.2023.
//

import Foundation

struct Сondition {
    let text: String
}

class СonditionManager {
    var condition: [Сondition] = []
    var currentCondition: Сondition?
    
    init() {
        // Добавляем слова в массив
        condition.append(Сondition(text: "Объясни с помощью слов."))
        condition.append(Сondition(text: "Объясни с помощью жестов."))
        condition.append(Сondition(text: "Объясни с помощью рисунка."))
        condition.append(Сondition(text: "Объясняй со злостью."))
        condition.append(Сondition(text: "Объясняй с помощью мимики."))
        condition.append(Сondition(text: "Объясняй вульгарно."))
        condition.append(Сondition(text: "Объясняй сексуально."))
    }
    
    func getNextCondition() -> Сondition? {
            // Получаем следующий элемент массива
            if let nextCondition = condition.randomElement() {
                currentCondition = nextCondition
                return nextCondition
            }
            return nil
        }
}
