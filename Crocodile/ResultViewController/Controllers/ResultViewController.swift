import UIKit

class ResultViewController: UIViewController {
    
    var teams: [TeamModel]!
    var teamViews: [UIView] = []
    var resultView = ResultView()
    
    // ВАЖНО!!! у teamView нужно выставить frame высоту 96 (> 0)
    override func viewDidLoad() {
        super.viewDidLoad()
//        generateForTest() // TestMethod
        setTeams(teams)
        resultView = ResultView()
        resultView.setElements(teams: teamViews)
        view = resultView
    }
    
     func setTeams(_ teams: [TeamModel]) {
        self.teams = teams
        self.teams.sort{$0.score > $1.score}
        setTeamViews()
    }
    
    private func setTeamViews() {
        for team in teams {
            let teamView = initTeamView(model: team)
            teamViews.append(teamView)
        }
    }
    
    private func initTeamView(model: TeamModel) -> TeamView {
            let frame = CGRect(x: 0, y: 0, width: 0, height: 96)
            let teamView = TeamView(frame: frame, model: model)
            return teamView
        }

//    // MARK: - TEST METHODS
//
//    private func generateForTest() {
//        var testTeams = [TeamModel]()
//        for _ in 0...9 {
//                    let model = TeamModel(name: "Name", image: UIImage(), score: Int.random(in: 0...7))
//                    testTeams.append(model)
//                }
//        setTeams(testTeams)
//    }
}
