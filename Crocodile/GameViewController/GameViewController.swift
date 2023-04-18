//
//  GameViewController.swift
//  Crocodile
//
//  Created by sidzhe on 15.04.2023.
//

import UIKit
import AVFAudio

class GameViewController: UIViewController {
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
    
    let conditionManager = СonditionManager()
    
    var timer: Timer?
    var counter = 0
    var audioPlayer: AVAudioPlayer?
    private let player = AudioManager()
    
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
    private lazy var randomWordLabel = UILabel(text: "Картошка")
    private lazy var conditionLabel = UILabel(text: "объясни с помощью жестов", font: UIFont.italicSystemFont(ofSize: 18))
    
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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
        startTimer()
        updateTimerLabel()
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
    
    private func startTimer() {
        counter = 25 // устанавливаем начальное значение счетчика
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimerLabel), userInfo: nil, repeats: true)
    }
    
    @objc
    private func updateTimerLabel() {
        counter -= 1 // уменьшаем значение счетчика на 1
        if counter == 10 {
            player.playSound(soundName: "10s") // воспроизводим звук, когда на таймере остается 10 секунд
            }

        if counter == 0 {
            timer?.invalidate() // останавливаем таймер, когда счетчик достигнет 0
        }
        let minutes = counter / 60 // вычисляем минуты
        let seconds = counter % 60 // вычисляем секунды
        timerLabel.text = String(format: "%02d:%02d", minutes, seconds) // форматируем строку с временем
    }
    
    @objc
    private func trueButtonTapped() {
        player.playSound(soundName: "pravilnyiyOtvet")
        
        UIView.animate(withDuration: 0.5, animations: {
            self.crocodileImage.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        }, completion: { _ in
            UIView.animate(withDuration: 0.5) {
                self.crocodileImage.transform = CGAffineTransform.identity
            }
        })
        
        if let condition = conditionManager.getNextCondition() {
                  conditionLabel.text = condition.text
              }
        
        
        print("Правильно")
    }
    
    @objc
    private func falseButtonTapped() {
        player.playSound(soundName: "gameLost")
        
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
        })
        print("Нарушил правила")
    }
    
    @objc
    private func resetButtonTapped() {
        let alertController = UIAlertController(title: "Сбросить игру?", message: "Вы хотите сбросить вашу игру и вернуться в главное меню?", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Да", style: .default) { (action) in
            // Обработка нажатия кнопки "Да"
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
