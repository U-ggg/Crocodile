import UIKit

class RulesView: UIView {
    
    weak var delegate: RulesViewDelegate?
    
    init(delegate: RulesViewDelegate? = nil) {
        super.init(frame: .zero)
        self.delegate = delegate
        self.setProperties()
        self.setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - scrollView
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = true
        return scrollView
    }()
    
    // MARK: - stack
    
    private lazy var stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 22
        stack.alignment = .leading
        stack.contentMode = .scaleToFill
        return stack
    }()
    
    // MARK: - backButton
    
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
        delegate?.rulesViewDidDismiss()
    }
    
    // MARK: - background
    
    private lazy var backgroundImage: UIImageView = {
        let backgroundImage = UIImageView()
        backgroundImage.image = UIImage(named: "background")
        backgroundImage.frame = bounds
        backgroundImage.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        backgroundImage.contentMode = .scaleAspectFill
        return backgroundImage
    }()
    
    // MARK: - rulesLabel
    
    private lazy var rules: UILabel = {
        let rules = UILabel()
        rules.font = .systemFont(ofSize: 18)
        rules.numberOfLines = 0
        rules.textAlignment = .left
        rules.lineBreakMode = .byWordWrapping
        rules.text =
        """
        В игру играют командами из двух или более человек.
        
        Задача каждого игрока команды - объяснить слово, которое он видит на экране, следуя условиям, которые дополнительно указаны под загаданным словом.
        
        Чем больше слов отгадала команда, тем больше она заработает баллов.
        
        Выигрывает команда, набравшая больше всего баллов.
        
        На отгадывание слова дается одна минуту.

        При нарушении правил объяснения слова, ход передается следующей команде.
        
        В игру играют командами из двух или более человек.
                
        Задача каждого игрока команды - объяснить слово, которое он видит на экране, следуя условиям, которые дополнительно указаны под загаданным словом.
                
        Чем больше слов отгадала команда, тем больше она заработает баллов.
                
        Выигрывает команда, набравшая больше всего баллов.
                
        На отгадывание слова дается одна минуту.

        При нарушении правил объяснения слова, ход передается следующей команде.
        
        """
        rules.sizeToFit()
        return rules
    }()
    
    func setProperties() {
        addSubview(backgroundImage)
        addSubview(scrollView)
        
        scrollView.addSubview(stack)
        stack.addArrangedSubview(backButton)
        stack.addArrangedSubview(rules)
        
    }
    
    // MARK: - Constraints
    
    private func setConstraints() {
        scrollView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10).isActive = true
        stack.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 10).isActive = true
        stack.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -10).isActive = true
        stack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -10).isActive = true
        stack.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -20).isActive = true
    }
}
