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
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(pressedButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var addButton: UIButton = {
        let button = UIButton()
        button.setTitle("Добавить команду", for: .normal)
        button.backgroundColor = UIColor(named: "BackgrColor")
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(addTeamPressed), for: .touchUpInside)
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
    
    private lazy var playLabel = UILabel(text: "Кто играет?")
    
    private lazy var backButton: UIButton = {
        let backButton = UIButton()
        let buttonImage = UIImage(systemName: "chevron.backward")
        backButton.setImage(buttonImage, for: .normal)
        backButton.tintColor = UIColor(red: 0.129, green: 0.588, blue: 0.953, alpha: 1)
        backButton.frame = CGRect(x: 0, y: 0, width: 11, height: 19)
        backButton.addTarget(self, action: #selector(backButtonIsPressed(sender:)), for: .touchUpInside)
        return backButton
    }()
    
    @objc func backButtonIsPressed(sender: UIButton) {
        dismiss(animated: true)
    }
    
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
        title = "Кто играет?"
        
        view.addSubview(imageBackgr)
        view.addSubview(backButton)
        view.addSubview(playLabel)
        view.addSubview(collectionView)
        view.addSubview(readyButton)
        view.addSubview(addButton)
        
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(15)
            make.left.equalToSuperview().inset(20)
        }
        
        playLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(1)
            make.left.equalTo(backButton.snp.left).inset(50)
            make.right.equalTo(view.snp.right).inset(50)
        }
        
        imageBackgr.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(playLabel.snp.bottom).offset(40)
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
    
    @objc private func addTeamPressed() {
        if TeamData.shared.teamArray.count == 6 {
            let alert = UIAlertController(title: "Информация",
                                          message: "Это максимальное количетсво команд",
                                          preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default)
            alert.addAction(action)
            present(alert, animated: true)
        } else {
            collectionView.insertItems(at: TeamData.shared.addTeam())
        }
    }
    
    @objc private func pressedButton() {
        guard TeamData.shared.checkSameName() else {
            let alert = UIAlertController(title: "Информация",
                                          message: "Есть одинаковые имена команд",
                                          preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default)
            alert.addAction(action)
            present(alert, animated: true)
            return
        }
        
        guard TeamData.shared.checkEmpty() else {
            let alert = UIAlertController(title: "Информация",
                                          message: "Некорректное имя команды",
                                          preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default)
            alert.addAction(action)
            present(alert, animated: true)
            return
        }
        
        let categoryViewController = CategoryViewController()
        categoryViewController.modalPresentationStyle = .fullScreen
        self.present(categoryViewController, animated: true)
        navigationController?.pushViewController(CategoryViewController(), animated: true)
    }
}

extension TeamViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return TeamData.shared.teamArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier,
                                                      for: indexPath)as? TeamViewCell
        cell?.delegate = self
        cell?.index = indexPath
        cell?.config(model: TeamData.shared.teamArray[indexPath.row])
        cell?.layer.backgroundColor = UIColor.white.cgColor
        cell?.layer.cornerRadius = 10
        return cell ?? UICollectionViewCell()
    }
    
}

extension TeamViewController: UICollectionViewDelegate, TeamViewCellDelegate {
    func updateText(text: String?, indexPath: IndexPath?) {
        TeamData.shared.teamArray[indexPath!.row].name = text ?? "Error"
    }
    
    func didSelectDelegate(cell: TeamViewCell) {
        guard let indexPath = collectionView.indexPath(for: cell) else { return }
        TeamData.shared.newTeamArray.append(TeamData.shared.teamArray[indexPath.row])
        TeamData.shared.teamArray.remove(at: indexPath.row)
        collectionView.deleteItems(at: [indexPath])
    }
}


protocol TeamViewCellDelegate: AnyObject {
    func didSelectDelegate(cell: TeamViewCell)
    func updateText(text: String?, indexPath: IndexPath?)
}
