//
//  TeamViewCell.swift
//  Crocodile
//
//  Created by sidzhe on 18.04.2023.
//

import UIKit
import SnapKit

class TeamViewCell: UICollectionViewCell {
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fillProportionally
        view.spacing = 25
        return view
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton(type: .custom)
        return button
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
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        return label
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
        stackView.addArrangedSubview(button)
//        stackView.addSubview(closeButton)
        stackView.addArrangedSubview(avatarImage)
        stackView.addArrangedSubview(nameLabel)

        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        avatarImage.snp.makeConstraints { make in
            make.height.width.equalTo(50)
        }
        
//        closeButton.snp.makeConstraints { make in
//            make.height.width.equalTo(25)
//            make.centerY.equalTo(nameLabel.snp.centerY)
//            make.right.equalToSuperview().inset(30)
//        }
    }
    
    public func config(model: TeamModel) {
        avatarImage.image = model.image
        nameLabel.text = model.name
    }
    
}
