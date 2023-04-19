//
//  ScoreView.swift
//  Crocodile
//
//  Created by Sergey Medvedev on 19.04.2023.
//

import UIKit

class ScoreView: UIView {
    // MARK: - winLabel
    let mainLabel: UILabel = {
        let label = UILabel()
        label.text = "Поздравляем"
        label.font = .systemFont(ofSize: 28, weight: .bold)
        
        return label
    }()
    // MARK: - secondLabel
    let secondLabel: UILabel = {
        let label = UILabel()
        label.text = "Вы получаете"
        label.font = .systemFont(ofSize: 17)
        
        return label
    }()
    // MARK: - starImageView
    let scoreImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "star")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        
        return imageView
    }()
    // MARK: - numberLabel
    let numberLabel: UILabel = {
        let label = UILabel()
        label.text = "1"
        label.font = .cookieMedium80()
        label.textColor = .white
        
        return label
    }()
    // MARK: - scoreLabel
    let scoreLabel: UILabel = {
        let label = UILabel()
        label.text = "Очки"
        label.font = .systemFont(ofSize: 15)
        label.textColor = UIColor(red: 1, green: 0.901, blue: 0.008, alpha: 1)
        
        return label
    }()
    // MARK: - bottomLabel
    let bottomLabel: UILabel = {
        let label = UILabel()
        label.text = "Следующий ход - 'Стройняшки'"
        label.font = .systemFont(ofSize: 16)
        
        return label
    }()
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - setupViews
    private func setupViews() {
        backgroundColor = UIColor(named: "bgButton")
        layer.cornerRadius = 20
        
        addSubview(mainLabel)
        addSubview(secondLabel)
        addSubview(scoreImageView)
        addSubview(numberLabel)
        addSubview(scoreLabel)
        addSubview(bottomLabel)
    }
    // MARK: - setConstrains
    private func setConstrains() {
        mainLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(43)
        }
        secondLabel.snp.makeConstraints { make in
            make.top.equalTo(mainLabel.snp.bottom).inset(-24)
            make.centerX.equalToSuperview()
        }
        scoreImageView.snp.makeConstraints { make in
            make.top.equalTo(secondLabel.snp.bottom).inset(-5)
            make.centerX.equalToSuperview()
        }
        numberLabel.snp.makeConstraints { make in
            make.centerX.equalTo(scoreImageView.snp.centerX)
            make.centerY.equalTo(scoreImageView.snp.centerY)
        }
        scoreLabel.snp.makeConstraints { make in
            make.top.equalTo(scoreImageView.snp.bottom).inset(5)
            make.centerX.equalToSuperview()
        }
        bottomLabel.snp.makeConstraints { make in
            make.top.equalTo(scoreLabel.snp.bottom).inset(-10)
            make.centerX.equalToSuperview()
        }
    }
}

