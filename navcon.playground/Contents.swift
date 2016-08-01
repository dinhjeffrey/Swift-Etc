// if the VC being segued to is a UIViewController...

extension UIViewController {
    var contentViewController: UIViewController {
        if let navcon = self as? UINavigationController {
            return navcon.visibleViewController ?? navcon
        } else {
            return self
        }
    }
}