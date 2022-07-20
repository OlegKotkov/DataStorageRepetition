
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemCyan
        
        //DataBaseManager.shared
        
        title = DataBaseManager.shared.getLaunchesNumber
    }
}

