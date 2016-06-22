import UIKit

class ColorVC: UIViewController, ChooseColorVCDelegate {

	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if segue.identifier == "chooseColor" {
			let vc = segue.destinationViewController as! ChooseColorVC
			vc.delegate = self
			vc.color = view.backgroundColor ?? UIColor.grayColor()
		}
	}
	
	func chooseColorVC(vc: ChooseColorVC, didChooseColor color: UIColor) {
		navigationController?.popViewControllerAnimated(true)
		self.view.backgroundColor = color
	}

}
