//
//  MainViewController.swift
//  Crocodile
//
//  Created by sidzhe on 15.04.2023.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    // MARK: - backgroundImageView
    
    let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "background 1")
        
        return imageView
    }()
    
    // MARK: - crocsImageView
    
    let crocsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "crocs")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    // MARK: - leftGrassImageView
    
    let leftGrassImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "grass 1")
        
        return imageView
    }()
    
    // MARK: - rightGrassImageView
    
    let rightGrassImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "grass 2")
        
        return imageView
    }()
    
    // MARK: - startbutton
    
    private lazy var startButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Старт игры", for: .normal)
        button.layer.backgroundColor = UIColor(red: 0.455, green: 0.655, blue: 0.188, alpha: 1).cgColor
        button.tintColor = .white
        button.layer.cornerRadius = 10
        button.titleLabel?.font = .systemFont(ofSize: 20)
        button.addTarget(self, action: #selector(tappedStartButton), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - rulesbutton
    
    private lazy var rulesButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Правила", for: .normal)
        button.layer.backgroundColor = UIColor(red: 0.455, green: 0.655, blue: 0.188, alpha: 1).cgColor
        button.tintColor = .white
        button.layer.cornerRadius = 10
        button.titleLabel?.font = .systemFont(ofSize: 17)
        button.addTarget(self, action: #selector(tappedRulesButton), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - resultbutton
    
    private lazy var resultButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Результаты", for: .normal)
        button.layer.backgroundColor = UIColor(red: 0.979, green: 0.47, blue: 0, alpha: 1).cgColor
        button.tintColor = .white
        button.layer.cornerRadius = 10
        button.titleLabel?.font = .systemFont(ofSize: 17)
        button.addTarget(self, action: #selector(tappedResultButton), for: .touchUpInside)
        
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstrains()
        
    }
    @objc
    private func tappedRulesButton() {
        print("Правила игры")
    }
    @objc
    private func tappedStartButton() {
        print("Старт игры")
    }
    @objc
    private func tappedResultButton() {
        print("Результаты")
    }
}

    // MARK: - setupViews

    extension MainViewController {
        private func setupViews() {
            view.addSubview(backgroundImageView)
            view.addSubview(crocsImageView)
            view.addSubview(leftGrassImageView)
            view.addSubview(rightGrassImageView)
            view.addSubview(rulesButton)
            view.addSubview(startButton)
            view.addSubview(resultButton)

        }
        
        // MARK: - setConstrains
        
        private func setConstrains() {
            
            // MARK: - backgroundImageView
            
            backgroundImageView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            
            // MARK: - crocsImageView
            
            crocsImageView.snp.makeConstraints { make in
                make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(60)
                make.centerX.equalTo(view.snp.centerX)
                make.height.equalTo(322)

            }
            
            // MARK: - leftGrassImageView
            
            leftGrassImageView.snp.makeConstraints { make in
                make.bottom.equalTo(view.snp.bottom).inset(0)
                make.leading.equalTo(0)
                make.height.equalTo(70)
                make.width.equalTo(95)
            }
            
            // MARK: - rightGrassImageView
            
            rightGrassImageView.snp.makeConstraints { make in
                make.bottom.equalTo(view.snp.bottom).inset(0)
                make.trailing.equalTo(0)
                make.height.equalTo(70)
                make.width.equalTo(95)
            }

            // MARK: - startbutton
            
            startButton.snp.makeConstraints { make in
                make.top.equalTo(crocsImageView.snp.bottom).inset(-20)
                make.left.equalTo(view.snp.left).inset(50)
                make.height.equalTo(83)
                make.centerX.equalTo(view.snp.centerX)
            }
            
            // MARK: - rulesbutton
            
            rulesButton.snp.makeConstraints { make in
                make.top.equalTo(startButton.snp.bottom).inset(-20)
                make.leading.equalTo(82)
                make.trailing.equalTo(-82)
                make.height.equalTo(63)
                    
            }
            
            // MARK: - resultbutton
        
            resultButton.snp.makeConstraints { make in
                make.top.equalTo(rulesButton.snp.bottom).inset(-20)
                make.leading.equalTo(82)
                make.trailing.equalTo(-82)
                make.height.equalTo(63)
                
            }
            
        }
    }


