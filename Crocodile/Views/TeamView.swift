import UIKit

class TeamView: UIView {
        
        // MARK: - smileImageView
        let smileImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.image = UIImage(named: "smileImage")
            imageView.contentMode = .scaleAspectFit
            imageView.clipsToBounds = true
            
            return imageView
        }()
        // MARK: - nameTeam
        let nameTeam: UILabel = {
            let label = UILabel()
            label.text = "Ковбои"
            label.font = .systemFont(ofSize: 22)
            
            return label
        }()
        // MARK: - numberLabel
        var numberLabel: UILabel = {
            let label = UILabel()
            label.text = "0"
            label.font = .cookieMedium65()
            
            return label
        }()
        // MARK: - scoreLabel
        let scoreLabel: UILabel = {
            let label = UILabel()
            label.text = "Очки"
            label.font = .systemFont(ofSize: 15)
            
            return label
        }()
        // MARK: - let/var
 
 var currentTeam = GameViewController.sharedCurentTeam
 var teamData = TeamData.shared
        
        // MARK: - init
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            setupViews()
            setConstrains()
        }
        
        init(frame: CGRect, model: TeamModel) {
            super.init(frame: frame)
            
            setupViews()
            setConstrains()
            
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        // MARK: - setupViews
        private func setupViews() {
            backgroundColor = .white
            layer.cornerRadius = 10
            
            addSubview(smileImageView)
            addSubview(nameTeam)
            addSubview(numberLabel)
            addSubview(scoreLabel)
   nameTeam.text = teamData.teamArray[currentTeam].name
   smileImageView.image = teamData.teamArray[currentTeam].image
            
        }
    
//    func updateTeamName(name: String) {
//  nameTeam.text = teamData.teamArray[currentTeam].name
//    }
//
//    func updateTeamScore(score: Int) {
//        numberLabel.text = "\(score)"
//    }
    
        // MARK: - setConstrains
        private func setConstrains() {
            smileImageView.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.leading.equalToSuperview().inset(15)
                make.top.equalToSuperview().inset(10)
                make.bottom.equalToSuperview().inset(10)
                make.width.equalTo(56)
            }
            nameTeam.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.leading.equalTo(smileImageView.snp.trailing).inset(-20)
            }
            numberLabel.snp.makeConstraints { make in
                make.trailing.equalToSuperview().inset(15)
            }
            scoreLabel.snp.makeConstraints { make in
                make.top.equalTo(numberLabel.snp.bottom).inset(10)
                make.trailing.equalToSuperview().inset(15)
            }
        }
    }
