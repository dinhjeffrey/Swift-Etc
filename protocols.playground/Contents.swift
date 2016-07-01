//: Playground - noun: a place where people can play

import UIKit

protocol Flyable {
    var flies: Bool {get set}
    
    func fly(distMiles: Double) -> String
}

class Vehicle: Flyable {
    var flies: Bool = false
    var name: String = "No Name"
    
    func fly(distMiles: Double) -> String {
        if(self.flies) {
            return "\(self.name) flies \(distMiles) miles"
        } else {
            return "\(self.name) can't fly"
        }
    }
}

var fordF150 = Vehicle()

fordF150.name = "Ford F-150"
fordF150.flies = false
print(fordF150.fly(150))

// Stanford

protocol Moveable {
    mutating func moveTo(p: CGPoint)
}
class Car: Moveable {
    func moveTo(p: CGPoint) {
        print("...")
    }
    func changeOil() {}
}
struct Shape: Moveable {
    mutating func moveTo(p: CGPoint) {
        print("...")
    }
    func draw() {}
}
let prius: Car = Car()
let square: Shape = Shape()

var thingsToMove: Moveable = prius
thingsToMove.moveTo(CGPoint(x: 1.0, y: 1.0))
//thingsToMove.changeOil()                // error out because thingsToMove is of Type Moveable, not Type Car

thingsToMove = square
let thingsToMoveArray: [Moveable] = [square, prius]

func slide(slider: Moveable) {
    var slider = slider
    let positionToSlideTo = CGPoint(x: 2.0, y: 2.0)
    slider.moveTo(positionToSlideTo)
}
slide(prius)
slide(square)
func slipAndSlide(x: protocol<Moveable>) {}
slipAndSlide(prius)









