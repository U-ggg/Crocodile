import UIKit

class RulesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let rulesView = RulesView()
        rulesView.setProperties()
        view = rulesView
    }
}

