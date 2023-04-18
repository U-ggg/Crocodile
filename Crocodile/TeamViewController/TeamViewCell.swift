//
//  TeamViewCell.swift
//  Crocodile
//
//  Created by sidzhe on 18.04.2023.
//

import UIKit
import SnapKit

class TeamViewCell: UICollectionViewCell {
    
    var model = TeamModel(name: "fdsf", image: UIImage(systemName: "swift")!)
    
    var editedText = String()
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fillProportionally
        view.alignment = .center
        view.spacing = 20
        return view
    }()
    
    private lazy var textFieldstackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fillProportionally
        view.spacing = 1
        return view
    }()
        
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "close"), for: .normal)
        return button
    }()

    private lazy var avatarImage: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .left
        textField.clearButtonMode = .whileEditing
        textField.placeholder = "Имя команды"
        textField.addTarget(self, action: #selector(ending(textField:)), for: .editingDidEndOnExit)
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        model.name = nameTextField.text!
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func ending(textField: UITextField) {
        textField.resignFirstResponder()
        editedText = textField.text ?? "Error"
        print(editedText)
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
    
    public func config(model: TeamModel) {
        avatarImage.image = model.image
        nameTextField.text = model.name
    }
}


