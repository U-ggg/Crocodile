//
//  GameViewController.swift
//  Crocodile
//
//  Created by sidzhe on 15.04.2023.
//

import UIKit
import AVFAudio

class GameViewController: UIViewController, ChangeDelegate {
    enum Constants {
        static let crocodileImageTopSpacing: CGFloat = 56.0
        static let crocodileImageSize: CGFloat = 230.0
        static let timerLabelTopSpacing: CGFloat = 26.0
        static let timerLabelSideSpacing: CGFloat = 26.0
        static let randomWordTopSpacing: CGFloat = 10.0
        static let randomWordSideSpacing: CGFloat = 64.0
        static let conditionLabelTopSpacing: CGFloat = 10.0
        static let conditionLabelSideSpacing: CGFloat = 90.0
        static let stackViewButtonTopSpacing: CGFloat = 106.0
        static let stackViewButtonSideSpacing: CGFloat = 10.0
        static let stackViewButtonBottomSpacing: CGFloat = 48.0
        static let buttonHeightSpacing: CGFloat = 60.0
    }
    
    private let conditionManager = СonditionManager()
    private var categoryModel = CategoryModel(name: "Животные", image: UIImage(named: "animal")!, words: ["кот"])
    public var selectedCategory: CategoryModel?
    
    private var timer: Timer?
    private var counter = 0
    private var trueButtonPressedCount = 0
    private var audioPlayer: AVAudioPlayer?
    private let player = AudioManager()
    
    var maxQestionNumber = TeamData.shared.teamArray.count * 2 //количество слов на 1 команду
    var question = 0
    var teamNumber = 0
    var nextTeamNumber = 1
    
    private lazy var backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "background")
        imageView.frame = view.bounds
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var crocodileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Image1")
        return imageView
    }()
    
    private lazy var timerLabel = UILabel(text: "")
    private lazy var randomWordLabel = UILabel(text: "")
    private lazy var conditionLabel = UILabel(text: "", font: UIFont.italicSystemFont(ofSize: 18))
    
    private lazy var trueButton = OptionsButton(text: "Правильно", color: .specialGreen)
    private lazy var falseButton = OptionsButton(text: "Нарушил правила", color: .specialRed)
    private lazy var resetButton = OptionsButton(text: "Сбросить", color: .specialGray)
    
    private lazy var stackViewButton = UIStackView()
    
    //MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let condition = conditionManager.getNextCondition() {
                  conditionLabel.text = condition.text
              }
        categoryModel.updateLabelWithRandomWord(category: selectedCategory!, label: randomWordLabel)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
        startTimer()
    }
    
    private func setupViews() {
        view.addSubview(backgroundImage)
        view.addSubview(crocodileImage)
        view.addSubview(timerLabel)
        view.addSubview(randomWordLabel)
        view.addSubview(conditionLabel)
        trueButton.addTarget(self, action: #selector(trueButtonTapped), for: .touchUpInside)
        falseButton.addTarget(self, action: #selector(falseButtonTapped), for: .touchUpInside)
        resetButton.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)
        stackViewButton = UIStackView(arrangedSubviews: [trueButton, falseButton, resetButton],
                                      axis: .vertical,
                                      spacing: 10.0)
        view.addSubview(stackViewButton)
    }
    
    internal func startTimer() {
        counter = 61 // устанавливаем начальное значение счетчика
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimerLabel), userInfo: nil, repeats: true)
    }
    
    @objc
    private func updateTimerLabel() {
        if counter > 0 {
            counter -= 1 // уменьшаем значение счетчика на 1
            let minutes = counter / 60 // вычисляем минуты
            let seconds = counter % 60 // вычисляем секунды
            timerLabel.text = String(format: "%02d:%02d", minutes, seconds) // форматируем строку с временем
        } else {
            timer?.invalidate() // останавливаем таймер, когда счетчик достигнет 0
        }
        
        if counter == 10 {
            player.playSound(soundName: "10s") // воспроизводим звук, когда на таймере остается 10 секунд
        }
    }
    

    
    func changeTeam() {
        teamNumber += 1
        if teamNumber > TeamData.shared.teamArray.count - 1 {
            teamNumber = 0
        }
        nextTeamNumber += 1
        if nextTeamNumber > TeamData.shared.teamArray.count - 1 {
            nextTeamNumber = 0
        }
    }
    
    
    @objc
    private func trueButtonTapped() {
        //Воспроизведение звука
        player.playSound(soundName: "pravilnyiyOtvet")

        //Добавление очка команде
        TeamData.shared.teamArray[teamNumber].addScore()
        
        //остановка таймера
        timer?.invalidate()

        //анимация
        UIView.animate(withDuration: 0.5, animations: {
            self.crocodileImage.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        }, completion: { _ in
            UIView.animate(withDuration: 0.5) {
                self.crocodileImage.transform = CGAffineTransform.identity
            }
            // показ экрана
            if self.question < self.maxQestionNumber {
                let correctVC = CorrectViewController()
                correctVC.delegate = self
                correctVC.teamView.smileImageView.image = TeamData.shared.teamArray[self.teamNumber].image
                correctVC.teamView.nameTeam.text = TeamData.shared.teamArray[self.teamNumber].name
                correctVC.teamView.numberLabel.text = (String(TeamData.shared.teamArray[self.teamNumber].score))
                correctVC.scoreView.bottomLabel.text = "Следующая команда - \(TeamData.shared.teamArray[self.nextTeamNumber].name)"
                correctVC.modalPresentationStyle = .fullScreen
                self.present(correctVC, animated: true)
            } else {
                print(TeamData.shared.teamArray)
                let resultVC = ResultViewController()
                resultVC.teams = TeamData.shared.teamArray
                resultVC.modalPresentationStyle = .fullScreen
                self.present(resultVC, animated: true)
            }
        })
        question += 1
    }
    
    @objc
    private func falseButtonTapped() {
        //Воспроизведение звука
        player.playSound(soundName: "gameLost")
        
        //остановка таймера
        timer?.invalidate()

        //анимация
        UIView.transition(with: self.crocodileImage, duration: 2.0, options: .transitionCrossDissolve, animations: {
            if self.crocodileImage.image == UIImage(named: "Image1") {
                self.crocodileImage.image = UIImage(named: "Image2")
            } else {
                self.crocodileImage.image = UIImage(named: "Image1")
            }
        }, completion: { finished in
            if finished {
                UIView.transition(with: self.crocodileImage, duration: 5.0, options: .transitionCrossDissolve, animations: {
                    self.crocodileImage.image = UIImage(named: "Image1")
                }, completion: nil)
            }
            if self.question < self.maxQestionNumber {
                let wrongVC = WrongViewController()
                wrongVC.delegate = self
                wrongVC.modalPresentationStyle = .fullScreen
                wrongVC.teamView.smileImageView.image = TeamData.shared.teamArray[self.teamNumber].image
                wrongVC.teamView.nameTeam.text = TeamData.shared.teamArray[self.teamNumber].name
                wrongVC.teamView.numberLabel.text = (String(TeamData.shared.teamArray[self.teamNumber].score))
                wrongVC.scoreView.bottomLabel.text = "Следующая команда - \(TeamData.shared.teamArray[self.nextTeamNumber].name)"
                self.present(wrongVC, animated: true)
            } else {
                print(TeamData.shared.teamArray)
                let resultVC = ResultViewController()
                resultVC.teams = TeamData.shared.teamArray
                resultVC.modalPresentationStyle = .fullScreen
                self.present(resultVC, animated: true)
            }
        })

        question += 1
    }
    
    @objc
    private func resetButtonTapped() {
        let alertController = UIAlertController(title: "Сбросить игру?", message: "Вы хотите сбросить вашу игру и вернуться в главное меню?", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Да", style: .default) { (action) in
            self.timer?.invalidate()
                       for i in 0...TeamData.shared.teamArray.count - 1 {
                           TeamData.shared.teamArray[i].nullScore()
                       }
                       let mainVC = MainViewController()
                       mainVC.modalPresentationStyle = .fullScreen
                       self.present(mainVC, animated: true)
        }
        alertController.addAction(okAction)
        okAction.setValue(UIColor.red, forKey: "titleTextColor")
        
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel) { (action) in
            // Обработка нажатия кнопки "Отмена"
        }
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
}

//MARK: - setConstraints()

extension GameViewController {
    private func setConstraints() {
        crocodileImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            crocodileImage.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.crocodileImageTopSpacing),
            crocodileImage.heightAnchor.constraint(equalToConstant: Constants.crocodileImageSize),
            crocodileImage.widthAnchor.constraint(equalToConstant: Constants.crocodileImageSize),
            crocodileImage.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        timerLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            timerLabel.topAnchor.constraint(equalTo: crocodileImage.bottomAnchor, constant: Constants.timerLabelTopSpacing),
            timerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.timerLabelSideSpacing),
            timerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.timerLabelSideSpacing)
        ])
        randomWordLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            randomWordLabel.topAnchor.constraint(equalTo: timerLabel.bottomAnchor, constant: Constants.randomWordTopSpacing),
            randomWordLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.randomWordSideSpacing),
            randomWordLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.randomWordSideSpacing)
        ])
        conditionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            conditionLabel.topAnchor.constraint(equalTo: randomWordLabel.bottomAnchor, constant: Constants.conditionLabelTopSpacing),
            conditionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.conditionLabelSideSpacing),
            conditionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.conditionLabelSideSpacing)
        ])
        trueButton.translatesAutoresizingMaskIntoConstraints = false
        falseButton.translatesAutoresizingMaskIntoConstraints = false
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            trueButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeightSpacing),
            falseButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeightSpacing),
            resetButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeightSpacing)
        ])
        stackViewButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackViewButton.topAnchor.constraint(equalTo: conditionLabel.bottomAnchor, constant: Constants.stackViewButtonTopSpacing),
            stackViewButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.stackViewButtonSideSpacing),
            stackViewButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.stackViewButtonSideSpacing),
            stackViewButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Constants.stackViewButtonBottomSpacing)
        ])
    }
}
