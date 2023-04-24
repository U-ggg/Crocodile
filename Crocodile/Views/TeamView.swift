//
//  TeamView1.swift
//  Crocodile
//
//  Created by Sergey Medvedev on 19.04.2023.
//

import UIKit

class TeamView: UIView {
    // MARK: - smileImageView
    var smileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: " ")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        
        return imageView
    }()
    // MARK: - nameTeam
    let nameTeam: UILabel = {
        let label = UILabel()
        label.text = " "
        label.font = .systemFont(ofSize: 22)
        
        return label
    }()
    // MARK: - numberLabel
    let numberLabel: UILabel = {
        let label = UILabel()
        label.text = " "
        label.font = .cookieMedium65()
        
        return label
    }()
    // MARK: - scoreLabel
    let scoreLabel: UILabel = {
        let label = UILabel()
        label.text = "Очки"
        label.font = .systemFont(ofSize: 15)
        
        return label
    }()
    // MARK: - let/var

    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setConstrains()
    }
    
    init(frame: CGRect, model: TeamModel) {
        super.init(frame: frame)
        
        setupViews()
        setConstrains()
        smileImageView.image = model.image
        nameTeam.text = model.name
        numberLabel.text = String(model.score)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - setupViews
    private func setupViews() {
        backgroundColor = .white
        layer.cornerRadius = 10
        
        addSubview(smileImageView)
        addSubview(nameTeam)
        addSubview(numberLabel)
        addSubview(scoreLabel)
    
    }
    // MARK: - setConstrains
    private func setConstrains() {
        smileImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(15)
            make.size.equalTo(56)
        }
        nameTeam.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(smileImageView.snp.trailing).inset(-34)
        }
        numberLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(15)
        }
        scoreLabel.snp.makeConstraints { make in
            make.top.equalTo(numberLabel.snp.bottom).inset(10)
            make.trailing.equalToSuperview().inset(15)
        }
    }
}

