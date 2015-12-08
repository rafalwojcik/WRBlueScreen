import UIKit
import WRBlueScreenSwift

class ViewController: UIViewController {

    @IBAction func showBSOD(sender: AnyObject) {
        WRBlueScreen.sharedWindow.showError(NSError(domain: "", code: 321, userInfo: nil))
    }

}

