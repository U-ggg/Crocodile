import UIKit

class ResultViewController: UIViewController {
    
    var teams: [UIView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let resultView = ResultView()
        resultView.setElements(teams: testViews) // replace with teams property
        view = resultView
    }

    // MARK: - for test
    
    private func getTestView() -> UIView {
        let testView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 96))
        testView.backgroundColor = .red
        return testView
    }
    
    private lazy var testViews: [UIView] = {
        var testViews: [UIView] = []
        for _ in 0...9 {
            testViews.append(getTestView())
        }
        return testViews
    }()
}

