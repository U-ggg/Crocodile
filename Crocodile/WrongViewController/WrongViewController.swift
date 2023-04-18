//
//  WrongViewController.swift
//  Crocodile
//
//  Created by sidzhe on 15.04.2023.
//

import UIKit

class WrongViewController: UIViewController {
    // MARK: - backgroundImageView
    let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "background")
        
        return imageView
    }()
    // MARK: - button
    let button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Передать ход", for: .normal)
        button.backgroundColor = UIColor(named: "bgButton")
        button.tintColor = .white
        button.layer.cornerRadius = 10
        button.titleLabel?.font = .systemFont(ofSize: 17)
        
        return button
    }()
    // MARK: - let/var
    let teamView = TeamView()
    let loseView = LoseView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstrains()
    }
}
extension WrongViewController {
    // MARK: - setupViews
    private func setupViews() {
        view.addSubview(backgroundImageView)
        view.addSubview(teamView)
        teamView.numberLabel.text = "2"
        view.addSubview(loseView)
        view.addSubview(button)
    }
    // MARK: - setConstrains
    private func setConstrains() {
        // MARK: - backgroundImageView
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        // MARK: - teamView
        teamView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(12)
            make.top.equalToSuperview().inset(84)
            make.height.equalTo(96)
        }
        // MARK: - button
        button.snp.makeConstraints { make in
            make.bottom.equalTo(view.snp.bottom).inset(46)
            make.leading.equalTo(12)
            make.trailing.equalTo(-12)
            make.height.equalTo(60)
        }
        // MARK: - loseView
        loseView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(12)
            make.top.equalTo(teamView.snp.bottom).inset(-86)
            make.height.equalTo(301)
        }
    }
}
