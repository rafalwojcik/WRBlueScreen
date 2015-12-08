import Foundation
import CoreText

private let BundleName = "WRBlueScreenBundle"
private let DOSFont = "PerfectDOSVGA437Win"
private let DOSFontFileName = "DOSFont"

public class WRBlueScreenView: UIView {
    
    @IBOutlet public var allLabels: [UILabel]!
    @IBOutlet public weak var errorLabel: UILabel!
    @IBOutlet public weak var blinkCursor: UILabel!
    
    static let resourcesBundle:NSBundle = {
        let bundlePath = NSBundle(forClass: WRBlueScreenView.self).pathForResource(BundleName, ofType: "bundle")
        return NSBundle(path: bundlePath!)!
    }()
    
    class func fromNibFile() -> WRBlueScreenView {
        return resourcesBundle.loadNibNamed("WRBlueScreenViewSwift", owner: nil, options: nil).first as! WRBlueScreenView
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        dynamicallyLoadFontNamed(DOSFontFileName)
        styleAllLabels()
    }
    
    func showErrorMessage(errorMessage: String) {
        errorLabel.text = "Error: \(errorMessage)"
    }
    
    private func styleAllLabels() {
        _ = allLabels.map { $0.font = UIFont(name: DOSFont, size: $0.font!.pointSize) }
        animateBlinkLabel()
    }
    
    private func animateBlinkLabel() {
        NSTimer.scheduledTimerWithTimeInterval(0.4, target: self, selector: Selector("changeAlphaOfBlinkCursor"), userInfo: nil, repeats: true)
    }
    
    internal func changeAlphaOfBlinkCursor() {
        blinkCursor.alpha = blinkCursor.alpha == 0.0 ? 1.0 : 0.0
    }
    
    private func dynamicallyLoadFontNamed(name: String) {
        let url = WRBlueScreenView.resourcesBundle.URLForResource(DOSFontFileName, withExtension: "ttf")
        guard let fontData = NSData(contentsOfURL: url!) else { return }
        let provider = CGDataProviderCreateWithCFData(fontData)
        guard let font = CGFontCreateWithDataProvider(provider) else { return }
        CTFontManagerRegisterGraphicsFont(font, nil)
    }
    
}