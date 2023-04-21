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
    
    private lazy var imageBackgr: UIImageView = {
        let image = UIImageView(image: UIImage(named: "background"))
        return image
    }()
    
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
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setKeyboardObservers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        removeKeyboardObservers()
    }
    
    private func setupViews() {
        view.addSubview(imageBackgr)
        view.addSubview(collectionView)
        view.addSubview(readyButton)
        view.addSubview(addButton)
        
        imageBackgr.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(addButton.snp.top).inset(10)
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
    
    private func setKeyboardObservers() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self,
                                       selector: #selector(self.willShowKeyboard(_:)),
                                       name: UIResponder.keyboardWillShowNotification,
                                       object: nil)
        notificationCenter.addObserver(self,
                                       selector: #selector(self.willHideKeyboard(_:)),
                                       name: UIResponder.keyboardWillHideNotification,
                                       object: nil)
    }
    
    private func removeKeyboardObservers() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self)
    }
    
    @objc private func willShowKeyboard(_ notification: NSNotification) {
        guard let keyboardHeight = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height else {
            return
        }
        
        if collectionView.frame.height > keyboardHeight {
            collectionView.contentInset.bottom = keyboardHeight
        }
    }
    
    @objc func willHideKeyboard(_ notification: NSNotification) {
        collectionView.contentInset.bottom = 0.0
    }
    
    @objc private func pressedButton(sender: UIButton) {
        if sender.currentTitle == readyButton.titleLabel?.text {
            navigationController?.pushViewController(CategoryViewController(), animated: true)
        } else if TeamData.shared.teamArray.count == 6 {
            let alert = UIAlertController(title: "Информация",
                                          message: "Это максимальное количетсво команд",
                                          preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default)
            alert.addAction(action)
            present(alert, animated: true)
        } else if sender.currentTitle == addButton.titleLabel?.text {
            TeamData.shared.addTeam()
            collectionView.reloadData()
        }
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
        cell?.layer.cornerRadius = 10
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


