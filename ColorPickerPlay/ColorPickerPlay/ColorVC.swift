import UIKit

class ColorVC: UIViewController, ChooseColorVCDelegate {

	override func viewDidLoad() {
		super.viewDidLoad()
	}

	@IBAction func chooseColor(sender: UIButton) {
		let vc = storyboard?.instantiateViewControllerWithIdentifier("chooseColorVC") as! ChooseColorVC
		vc.delegate = self
		vc.color = view.backgroundColor ?? UIColor.grayColor()
		
		presentViewController(vc, animated: true, completion: nil)
	}
	
	func chooseColorVC(vc: ChooseColorVC, didChooseColor color: UIColor) {
		dismissViewControllerAnimated(true) {
			self.view.backgroundColor = color
		}
	}
	
	func chooseColorVCDidCancel(vc: ChooseColorVC) {
		dismissViewControllerAnimated(true, completion: nil)
	}

}
