import UIKit

protocol RulesViewDelegate: AnyObject {
    func rulesViewDidDismiss()
}

class RulesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let rulesView = RulesView()
        rulesView.setProperties()
        view = rulesView
        rulesView.delegate = self
    }
}

extension RulesViewController: RulesViewDelegate {
    func rulesViewDidDismiss() {
        dismiss(animated: true, completion: nil)
    }
}
