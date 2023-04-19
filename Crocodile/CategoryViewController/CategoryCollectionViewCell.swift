//
//  CategoryCollectionViewCell.swift
//  Crocodile
//
//  Created by Евгений Житников on 18.04.2023.
//

import UIKit

import UIKit

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
        NSLayoutConstraint.activate([
            categoryImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            categoryImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            categoryImage.heightAnchor.constraint(equalToConstant: 56),
            categoryImage.widthAnchor.constraint(equalToConstant: 56),
            
            categoryName.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            categoryName.centerYAnchor.constraint(equalTo: categoryImage.centerYAnchor),
            
            checkmarkImageView.centerYAnchor.constraint(equalTo: categoryImage.centerYAnchor),
            checkmarkImageView.heightAnchor.constraint(equalToConstant: 30),
            checkmarkImageView.widthAnchor.constraint(equalToConstant: 30),
            checkmarkImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
        ])
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
