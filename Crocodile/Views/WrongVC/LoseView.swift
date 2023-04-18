//
//  lLoseVc.swift
//  Crocodile
//
//  Created by Sergey Medvedev on 17.04.2023.
//

import UIKit

class LoseView: UIView {
    // MARK: - loseLabel
    let loseLabel: UILabel = {
        let label = UILabel()
        label.text = "УВЫ И АХ"
        label.font = .systemFont(ofSize: 28, weight: .bold)
        
        return label
    }()
    // MARK: - secondLabel
    let secondLabel: UILabel = {
        let label = UILabel()
        label.text = "Вы не отгадали слово и не получаете \n очков"
        label.font = .systemFont(ofSize: 18)
        label.textAlignment = .center
        label.numberOfLines = 0
        
        return label
    }()
    // MARK: - circleImageView
    let circleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "circle")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        
        return imageView
    }()
    // MARK: - numberLabel
    let numberLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = .cookieMedium80()
        label.textColor = .white
        
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
        backgroundColor = UIColor(named: "red")
        layer.cornerRadius = 20
        
        addSubview(loseLabel)
        addSubview(secondLabel)
        addSubview(circleImageView)
        addSubview(numberLabel)
        addSubview(bottomLabel)
    }
    // MARK: - setConstrains
    private func setConstrains() {
        // MARK: - loseLabel
        loseLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(43)
        }
        // MARK: - secondLabel
        secondLabel.snp.makeConstraints { make in
            make.top.equalTo(loseLabel.snp.bottom).inset(-24)
            make.leading.equalToSuperview().inset(10)
            make.trailing.equalToSuperview().inset(10)
            make.centerX.equalToSuperview()
        }
        // MARK: - circleImageView
        circleImageView.snp.makeConstraints { make in
            make.top.equalTo(secondLabel.snp.bottom).inset(-10)
            make.centerX.equalToSuperview()
        }
        // MARK: - numberLabel
        numberLabel.snp.makeConstraints { make in
            make.centerX.equalTo(circleImageView.snp.centerX)
            make.centerY.equalTo(circleImageView.snp.centerY)
        }
        // MARK: - bottomLabel
        bottomLabel.snp.makeConstraints { make in
            make.top.equalTo(circleImageView.snp.bottom).inset(-10)
            make.centerX.equalToSuperview()
        }
    }
}
