//
//  CategoryModel.swift
//  Crocodile
//
//  Created by Евгений Житников on 18.04.2023.
//

import Foundation
import UIKit

struct CategoryModel {
    let name: String
    let image: UIImage
    let words: [String]
    var lastWord: String?
    
    mutating func updateLabelWithRandomWord(category: CategoryModel, label: UILabel) {
        var randomIndex = Int.random(in: 0..<category.words.count)
        var randomWord = category.words[randomIndex]
        while randomWord == lastWord {
            randomIndex = Int.random(in: 0..<category.words.count)
            randomWord = category.words[randomIndex]
        }
        lastWord = randomWord
        label.text = randomWord
    }
    
}

let categories: [CategoryModel] = [
    CategoryModel(name: "Животные", image: UIImage(named: "animal")!, words: ["кот", "собака", "корова", "лошадь", "крокодил", "тигр", "слон", "кенгуру", "жираф", "обезьяна", "козел", "овца", "свинья", "дятел", "лиса", "волк", "медведь", "ягуар", "леопард", "носорог"]),
    CategoryModel(name: "Еда", image: UIImage(named: "food")!, words: ["бургер", "пицца", "суши", "гамбургер", "тайская еда", "суп", "хот-дог", "мороженое", "шаурма", "макароны", "роллы", "борщ", "цезарь", "салат", "стейк", "рыба", "фрукты", "овощи", "картофель", "манго"]),
    CategoryModel(name: "Личности", image: UIImage(named: "person")!, words: ["Джонни Депп", "Элтон Джон", "Майкл Джордан", "Леди Гага", "Ариана Гранде", "Дональд Трамп", "Анджелина Джоли", "Леонардо Ди Каприо", "Рианна", "Джей-Зи", "Мадонна", "Тейлор Свифт", "Кейт Миддлтон", "Принц Уильям", "Джимми Фэллон", "Джим Керри", "Том Круз", "Дженнифер Лоуренс", "Брэд Питт", "Кристиано Роналдо"]),
    CategoryModel(name: "Хобби", image: UIImage(named: "hobby")!, words: ["видеоигры", "шахматы", "танцы", "фотография", "гольф", "бег", "плавание", "велоспорт", "баскетбол", "бокс", "бейсбол", "рыбалка", "вязание", "шитье", "вышивание", "карандашное искусство", "садоводство"])
]
