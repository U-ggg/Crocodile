//
//  CorrectViewController.swift
//  Crocodile
//
//  Created by sidzhe on 15.04.2023.
//

import UIKit
import SnapKit

protocol ChangeDelegate: AnyObject {
    func changeTeam()
    func startTimer()
}

class CorrectViewController: UIViewController {
    
    weak var delegate: ChangeDelegate?
    
    // MARK: - backgroundImageView
    let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "background")
        
        return imageView
    }()
    // MARK: - button
    private lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Передать ход", for: .normal)
        button.backgroundColor = UIColor(named: "bgButton")
        button.tintColor = .white
        button.layer.cornerRadius = 10
        button.titleLabel?.font = .systemFont(ofSize: 17)
        button.addTarget(self, action: #selector(backView), for: .touchUpInside)
        return button
    }()
    
    @objc  func backView() {
        dismiss(animated: true)
        delegate?.changeTeam()
        delegate?.startTimer()
    }
    
    // MARK: - let/var
    let teamView = TeamView()
    let scoreView = ScoreView()
    // MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstrains()
    }
}
extension CorrectViewController {
    // MARK: - setupViews
    private func setupViews() {
        view.addSubview(backgroundImageView)
        view.addSubview(teamView)
        view.addSubview(scoreView)
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
        // MARK: - winView
        scoreView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(12)
            make.top.equalTo(teamView.snp.bottom).inset(-86)
            make.height.equalTo(301)
        }
        // MARK: - button
        button.snp.makeConstraints { make in
            make.bottom.equalTo(view.snp.bottom).inset(46)
            make.leading.equalTo(12)
            make.trailing.equalTo(-12)
            make.height.equalTo(60)
        }
    }
}
