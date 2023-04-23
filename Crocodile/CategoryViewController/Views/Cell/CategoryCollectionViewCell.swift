//
//  CategoryCollectionViewCell.swift
//  Crocodile
//
//  Created by Евгений Житников on 18.04.2023.
//

import UIKit
import SnapKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    lazy var checkmarkImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "checkmark.circle.fill"))
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isHidden = true
        return imageView
    }()
    
    lazy var categoryName: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 20, weight: .bold)
        view.textColor = .white
        view.numberOfLines = 0
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var categoryImage: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.cornerRadius = 28
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        contentView.addSubview(categoryName)
        contentView.addSubview(categoryImage)
        contentView.addSubview(checkmarkImageView)
    }
    
    func setupConstraints() {
        categoryImage.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.leading.equalToSuperview().offset(20)
            make.size.equalTo(56)
        }
        
        categoryName.snp.makeConstraints { make in
            make.centerX.equalTo(contentView)
            make.centerY.equalTo(categoryImage)
        }
        
        checkmarkImageView.snp.makeConstraints { make in
            make.centerY.equalTo(categoryImage)
            make.trailing.equalToSuperview().inset(20)
            make.size.equalTo(30)
        }
    }
    
    public func refresh(_ model: CategoryModel) {
        categoryName.text = model.name
        categoryImage.image = model.image
    }
    
    override var isSelected: Bool {
        didSet {
            checkmarkImageView.isHidden = !isSelected
        }
    }
    
}
