import UIKit

class ResultView: UIView {
    
    var teams: [UIView]!
    private let teamSpacing = 22
    
    // MARK:  background
    
    private lazy var backgroundImage: UIImageView = {
        let backgroundImage = UIImageView()
        backgroundImage.image = UIImage(named: "background")
        backgroundImage.frame = bounds
        backgroundImage.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        backgroundImage.contentMode = .scaleAspectFill
        return backgroundImage
    }()
    
    // MARK: header
    
    private lazy var header: UILabel = {
        let header = UILabel()
        header.text = "Результаты"
        header.font = .systemFont(ofSize: 32)
        header.textAlignment = .center
        header.numberOfLines = 1
        header.sizeToFit()
        return header
    }()
    
    // MARK: repeatButton
    
    private lazy var repeatButton: UIButton = {
        let repeatButton = UIButton()
        repeatButton.backgroundColor = UIColor(red: 0.455, green: 0.655, blue: 0.188, alpha: 1)
        repeatButton.setTitle("Начать сначала", for: .normal)
        repeatButton.setTitleColor(.white, for: .normal)
        repeatButton.layer.cornerRadius = 10
        repeatButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        repeatButton.addTarget(self, action: #selector(repeatButtonPressed), for: .touchUpInside)
        return repeatButton
    }()
    
    
    // MARK: - scroll
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.contentSize = contentSize
        scrollView.indicatorStyle = .white
        return scrollView
    }()
    
    private lazy var teamStack: UIStackView = {
        let teamStack = UIStackView()
        teamStack.axis = .vertical
        teamStack.spacing = CGFloat(teamSpacing)
        teamStack.alignment = .center
        return teamStack
    }()
    
    func fillTeamStack() {
        for team in teams {
            teamStack.addArrangedSubview(team)
        }
    }
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = .white
        contentView.frame.size = contentSize
        return contentView
    }()
    
    private lazy var contentSize: CGSize = {
        let height = teams.count * (Int(teams[0].frame.height) + teamSpacing - 1)
        return CGSize(width: self.frame.width, height: Double(height))
    }()
    
    // MARK: - init and set
    
    func setElements(teams: [UIView]) {
        self.teams = teams
        fillTeamStack()
        addSubview(backgroundImage)
        sendSubviewToBack(backgroundImage)
        addSubview(header)
        addSubview(repeatButton)
        
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(teamStack)
        setConstraints()
    }
    
    // MARK: - constraints
    
    private func setConstraints() {

        // MARK: button
        
        repeatButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            repeatButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            repeatButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 12),
            repeatButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -12),
        ])
        
        // MARK: header
        
        header.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            header.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            header.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
        
        // MARK: scroll
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.bottomAnchor.constraint(equalTo: repeatButton.topAnchor, constant: -30),
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 30),
        ])
        
        // MARK: teamStack
        
        teamStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            teamStack.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 12),
            teamStack.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -12)
        ])
        
        // MARK: teamViews
        
        for teamView in teams{
            teamView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                teamView.leadingAnchor.constraint(equalTo: teamStack.leadingAnchor),
                teamView.trailingAnchor.constraint(equalTo: teamStack.trailingAnchor),
                teamView.heightAnchor.constraint(equalToConstant: teamView.frame.height)
            ])
        }
    }
}

extension ResultView {
    @objc private func repeatButtonPressed() {
        let viewController = self.next as! UIViewController
        let mainViewController = MainViewController()
        mainViewController.modalPresentationStyle = .fullScreen
        viewController.present(mainViewController, animated: true)
        TeamData.shared.resetTeamArray()
    }
}
