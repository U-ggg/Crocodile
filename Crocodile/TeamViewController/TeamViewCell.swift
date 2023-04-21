//
//  TeamViewCell.swift
//  Crocodile
//
//  Created by sidzhe on 18.04.2023.
//

import UIKit
import SnapKit

class TeamViewCell: UICollectionViewCell {
    
    weak var delegate: TeamViewCellDelegate?
    
    var index: IndexPath?
    
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
        button.addTarget(self, action: #selector(deletedCloseButton), for: .touchUpInside)
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
        textField.delegate = self
        textField.addTarget(self, action: #selector(textChange(textField:)), for: .editingChanged)
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(avatarImage)
        stackView.addArrangedSubview(nameTextField)
        stackView.addArrangedSubview(closeButton)
        
        stackView.snp.makeConstraints { make in
            make.verticalEdges.equalTo(contentView.safeAreaLayoutGuide.snp.verticalEdges)
            make.horizontalEdges.equalToSuperview().inset(30)
        }
        
        avatarImage.snp.makeConstraints { make in
            make.size.equalTo(50)
        }
        
        closeButton.snp.makeConstraints { make in
            make.size.equalTo(25)
        }
    }
         
    private func hideCloseButton() {
        if TeamData.shared.teamArray.count > 2 {
            closeButton.isHidden = false
        } else {
            closeButton.isHidden = true
        }
    }
    
    @objc private func textChange(textField: UITextField) {
        delegate?.updateText(text: textField.text, indexPath: index)
    }
    
    @objc private func deletedCloseButton() {
        delegate?.didSelectDelegate(cell: self)
    }
    
    public func config(model: TeamModel) {
        avatarImage.image = model.image
        nameTextField.text = model.name
        hideCloseButton()
    }
}

extension TeamViewCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
}

