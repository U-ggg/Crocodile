//
//  TeamViewController.swift
//  Crocodile
//
//  Created by sidzhe on 18.04.2023.
//

import UIKit
import SnapKit

class TeamViewController: UIViewController {
    
    private let identifier = "Cell"
    
    private lazy var readyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Игроки готовы", for: .normal)
        button.backgroundColor = UIColor(named: "BackgrColor")
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(pressedButton(sender:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var addButton: UIButton = {
        let button = UIButton()
        button.setTitle("Добавить команду", for: .normal)
        button.backgroundColor = UIColor(named: "BackgrColor")
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(pressedButton(sender:)), for: .touchUpInside)
        return button
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UILayoutGuide()
        let view = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        view.backgroundView = UIImageView(image: UIImage(named: "background"))
        view.delegate = self
        view.dataSource = self
        view.register(TeamViewCell.self, forCellWithReuseIdentifier: identifier)
        return view
    }()
    
    private lazy var flowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.itemSize = CGSize(width: 350, height: 80)
        return flowLayout
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        notification()
        
    }
    
    private func notification() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(notification:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(notification:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    private func setupViews() {
        view.addSubview(collectionView)
        view.addSubview(readyButton)
        view.addSubview(addButton)
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        readyButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(80)
            make.bottom.equalToSuperview().inset(25)
        }
        
        addButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(80)
            make.bottom.equalTo(readyButton.snp.top).offset(-20)
        }
    }
    
    @objc private func pressedButton(sender: UIButton) {
        if sender.currentTitle == readyButton.titleLabel?.text {
            navigationController?.pushViewController(CategoryViewController(), animated: true)
        } else if sender.currentTitle == addButton.titleLabel?.text {
            TeamData.shared.addTeam()
            collectionView.reloadData()
        } else {
            let alert = UIAlertController(title: "Информация",
                                          message: "Это максимальное количетсво команд",
                                          preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default)
            alert.addAction(action)
            present(alert, animated: true)
        }
    }
    
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if TeamData.shared.teamArray.count > 4 {
            guard let userInfo = notification.userInfo else { return }
            guard let keyboardSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
            view.frame.origin.y -= keyboardSize.height / 2
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        view.frame.origin.y = 0
    }
}


extension TeamViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        TeamData.shared.teamArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier,
                                                      for: indexPath)as? TeamViewCell
        cell?.delegate = self
        cell?.closeButton.tag = indexPath.row
        cell?.nameTextField.tag = indexPath.row
        cell?.config(model: TeamData.shared.teamArray[indexPath.row])
        cell?.layer.backgroundColor = UIColor.white.cgColor
        cell?.layer.cornerRadius = 25
        return cell ?? UICollectionViewCell()
    }
}

extension TeamViewController: UICollectionViewDelegate, TeamViewCellDelegate {
    func didSelectDelegate(index: Int) {
        TeamData.shared.newTeamArray.append(TeamData.shared.teamArray[index])
        TeamData.shared.teamArray.remove(at: index)
        TeamData.shared.removeAnimation = index
        collectionView.reloadData()
    }
}


protocol TeamViewCellDelegate: AnyObject {
    func didSelectDelegate(index: Int)
}


