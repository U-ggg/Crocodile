//
//  Category.swift
//  test
//
//  Created by Евгений Житников on 18.04.2023.
//

import UIKit
import SnapKit

class CategoryViewController: UIViewController {
    
    let categoryCellIdentifire = "categoryCell"
    
    
    let titleLabel: UILabel = {
        let view = UILabel()
        view.text = "Категории"
        view.textAlignment = .center
        view.font = UIFont.boldSystemFont(ofSize: 34)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "background")
        imageView.frame = view.bounds
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let categoryCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var startGameButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = UIColor(named: "Bottom color")
        view.setTitleColor(.white, for: .normal)
        view.setTitle("Начать игру", for: .normal)
        view.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        view.layer.cornerRadius = 10
        view.addTarget(self, action: #selector(startGameButtonPressed), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryCollection.backgroundColor = .clear
        addSubviews()
        setupCollectionView()
        setupConstraints()
    }
    
    func addSubviews() {
        view.addSubview(backgroundImage)
        view.addSubview(titleLabel)
        view.addSubview(categoryCollection)
        view.addSubview(startGameButton)
    }
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        categoryCollection.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.equalTo(view.snp.leading).offset(16)
            make.trailing.equalTo(view.snp.trailing).offset(-16)
            make.bottom.equalTo(startGameButton.snp.top).offset(-16)
        }
        
        startGameButton.snp.makeConstraints { make in
            make.height.equalTo(63)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(14)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-14)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-63)
        }
    }
    
    func setupCollectionView() {
        categoryCollection.delegate = self
        categoryCollection.dataSource = self
        categoryCollection.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: categoryCellIdentifire)
        categoryCollection.backgroundColor = .clear
        categoryCollection.showsVerticalScrollIndicator = false
    }
}

extension CategoryViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 32, height: categoryCollection.frame.height / 6)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 25
    }
}

extension CategoryViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: categoryCellIdentifire, for: indexPath) as! CategoryCollectionViewCell
        let category = categories[indexPath.row]
        cell.refresh(category)
        switch indexPath.row {
        case 0:
            cell.contentView.backgroundColor = UIColor(named: "first cell color")
        case 1:
            cell.contentView.backgroundColor = UIColor(named: "second cell color")
        case 2:
            cell.contentView.backgroundColor = UIColor(named: "third cell color")
        case 3:
            cell.contentView.backgroundColor = UIColor(named: "fourth cell color")
        default:
            break
        }
        
        cell.isSelected = collectionView.indexPathsForSelectedItems?.contains(indexPath) ?? false
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CategoryCollectionViewCell
        
        if let selectedIndexPaths = collectionView.indexPathsForSelectedItems,
           let selectedIndex = selectedIndexPaths.firstIndex(where: { $0 != indexPath }) {
            let deselectedIndexPath = selectedIndexPaths[selectedIndex]
            let deselectedCell = collectionView.cellForItem(at: deselectedIndexPath) as! CategoryCollectionViewCell
            deselectedCell.isSelected = false
            collectionView.deselectItem(at: deselectedIndexPath, animated: true)
        }
        
        cell.isSelected = true
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CategoryCollectionViewCell
        
        cell.isSelected = false
    }
    
    @objc func startGameButtonPressed() {
        guard let selectedIndexPath = categoryCollection.indexPathsForSelectedItems?.first else {
            let alert = UIAlertController(title: "Внимание!", message: "Для начала игры необходимо выбрать одну из категорий", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            return
        }
        
        let selectedCategory = categories[selectedIndexPath.row]
        
        let gameViewController = GameViewController()
        gameViewController.modalPresentationStyle = .fullScreen
        gameViewController.selectedCategory = selectedCategory
        present(gameViewController, animated: true)
        navigationController?.pushViewController(gameViewController, animated: true)
    }
}
