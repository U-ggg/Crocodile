//
//  TeamViewCell.swift
//  Crocodile
//
//  Created by sidzhe on 18.04.2023.
//

import UIKit
import SnapKit

class TeamViewCell: UICollectionViewCell, UITextFieldDelegate {
    
    var startEditing = String()
    var endEditing = String()
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fillProportionally
        view.alignment = .center
        view.spacing = 20
        return view
    }()
    
    lazy var closeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "close"), for: .normal)
        button.isHidden = true
        button.addTarget(self, action: #selector(deletedCloseButton(sender:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var editButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "pencil"), for: .normal)
        button.addTarget(self, action: #selector(selectedEditButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var avatarImage: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .left
        textField.clearButtonMode = .whileEditing
        textField.placeholder = "Имя команды"
        textField.isEnabled = false
        textField.delegate = self
        textField.addTarget(self, action: #selector(ending(textField:)), for: .editingDidEndOnExit)
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func selectedEditButton() {
        if nameTextField.isEnabled == false {
            nameTextField.isEnabled = !nameTextField.isEnabled
            nameTextField.becomeFirstResponder()
            startEditing = nameTextField.text ?? "Error"
        } else {
            nameTextField.isEnabled = !nameTextField.isEnabled
            nameTextField.becomeFirstResponder()
            endEditing = nameTextField.text ?? "Error"
            for i in 0..<TeamData.shared.teamArray.count {
                if TeamData.shared.teamArray[i].name == startEditing {
                    TeamData.shared.teamArray[i].name = endEditing
                }
            }
        }
    }
    
    @objc private func ending(textField: UITextField) {
        textField.resignFirstResponder()
        endEditing = textField.text ?? "Error"
        
        for i in 0..<TeamData.shared.teamArray.count {
            if TeamData.shared.teamArray[i].name == startEditing {
                TeamData.shared.teamArray[i].name = endEditing
            }
        }
    }
    
    private func hideCloseButton() {
        if TeamData.shared.teamArray.count > 2 {
            closeButton.isHidden = false
        } else {
            closeButton.isHidden = true
        }
    }
    
    private func deleteArrayValue() {
        
    }
    
    @objc private func deletedCloseButton(sender: UIButton) {
        print(sender.tag)
        for i in 0..<TeamData.shared.teamArray.count {
            if sender.tag == i {
                TeamData.shared.newTeamArray.append(TeamData.shared.teamArray[i])
                TeamData.shared.teamArray.remove(at: i)
            }
        }
    }
    
    private func setupViews() {
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(avatarImage)
        stackView.addArrangedSubview(nameTextField)
        stackView.addArrangedSubview(editButton)
        stackView.addArrangedSubview(closeButton)
        
        stackView.snp.makeConstraints { make in
            make.verticalEdges.equalTo(contentView.safeAreaLayoutGuide.snp.verticalEdges)
            make.horizontalEdges.equalToSuperview().inset(30)
        }
        
        avatarImage.snp.makeConstraints { make in
            make.size.equalTo(50)
        }
        
        editButton.snp.makeConstraints { make in
            make.size.equalTo(25)
        }
        
        closeButton.snp.makeConstraints { make in
            make.size.equalTo(25)
        }
    }
    
    public func config(model: TeamModel) {
        avatarImage.image = model.image
        nameTextField.text = model.name
        hideCloseButton()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
        endEditing = textField.text ?? "Error"
        
        for i in 0..<TeamData.shared.teamArray.count {
            if TeamData.shared.teamArray[i].name == startEditing {
                TeamData.shared.teamArray[i].name = endEditing
            }
        }
        nameTextField.isEnabled = false
    }
    
}
