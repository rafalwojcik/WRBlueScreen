import Foundation
import Darwin

public class WRBlueScreen: UIWindow {
    
    public static let sharedWindow = WRBlueScreen()
    public var shouldCrashApplication = true
    public var percentageChanceToCrash:Int = 70
    public var minIntervalToCrash:Int = 2
    public var maxIntervalToCrash:Int = 5
    
    private lazy var blueScreenView:WRBlueScreenView = WRBlueScreenView.fromNibFile()

    init() {
        super.init(frame: UIScreen.mainScreen().bounds)
        blueScreenView.frame = self.bounds
        self.addSubview(blueScreenView)
    }

    required public init?(coder aDecoder: NSCoder) { super.init(coder: aDecoder) }
    
    public func showErrorMessage(errorMessage:String) {
        hideKeybaord()
        blueScreenView.showErrorMessage(errorMessage)
        hidden = false
        makeKeyAndVisible()
        if shouldCrashApplication { randomCrashApp() }
    }
    
    public func showError(error: NSError) {
        self.showErrorMessage("\(error.code) : \(unsafeAddressOf(error))")
    }
    
    private func hideKeybaord() {
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(0.0)
        UIView.setAnimationDelay(0.0)
        UIView.setAnimationCurve(.Linear)
        _ = UIApplication.sharedApplication().windows.map { $0.endEditing(true) }
        UIView.commitAnimations()
    }
        
    private func randomCrashApp() {
        let randomNumber = 1 + arc4random() % 100
        if randomNumber <= UInt32(percentageChanceToCrash) {
            let randomCrashTime =
                minIntervalToCrash >= maxIntervalToCrash ? minIntervalToCrash : minIntervalToCrash + Int(arc4random()) % (maxIntervalToCrash - minIntervalToCrash + 1)
            NSTimer.scheduledTimerWithTimeInterval(Double(randomCrashTime), target: self, selector: Selector("crashApp"), userInfo: nil, repeats: false)
        }
    }
    
    func crashApp() {
        print("BSOD")
        [][666]
    }
}