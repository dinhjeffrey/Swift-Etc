import UIKit

protocol ChooseColorVCDelegate {
	func chooseColorVC(vc: ChooseColorVC, didChooseColor color: UIColor)
	func chooseColorVCDidCancel(vc: ChooseColorVC)
}

class ChooseColorVC: UIViewController {

	@IBOutlet weak var redSlider: UISlider!
	@IBOutlet weak var greenSlider: UISlider!
	@IBOutlet weak var blueSlider: UISlider!
	
	var delegate: ChooseColorVCDelegate?
	var color: UIColor = UIColor.grayColor()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		var red: CGFloat = 0
		var green: CGFloat = 0
		var blue: CGFloat = 0
		var alpha: CGFloat = 0
		color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
		
		redSlider.value = Float(red)
		greenSlider.value = Float(green)
		blueSlider.value = Float(blue)
		
		view.backgroundColor = color
	}
	
	@IBAction func changeColor(sender: UISlider) {
		color = UIColor(
			red: CGFloat(redSlider.value),
			green: CGFloat(greenSlider.value),
			blue: CGFloat(blueSlider.value),
			alpha: 1
		)
		view.backgroundColor = color
	}
	
	@IBAction func useColor(sender: UIButton) {
		delegate?.chooseColorVC(self, didChooseColor: color)
	}

	@IBAction func cancel(sender: UIButton) {
		delegate?.chooseColorVCDidCancel(self)
	}
	
}
