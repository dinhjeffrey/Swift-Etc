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


// Protocols: Property Requirements

protocol FullyNamed {
    var fullName: String { get }
}

struct Person: FullyNamed {
    var fullName: String
}

let john = Person(fullName: "John Appleseed")
john.fullName

class Starship: FullyNamed {
    var prefix: String?
    var name: String
    init(name: String, prefix: String?) {
        self.name = name
        self.prefix = prefix
    }
    var fullName: String {
        return (prefix != nil ? "\(prefix!) ": "") + name
    }
}

var ncc1701 = Starship(name: "Enterprise", prefix: "USS")
ncc1701.fullName

// Protocols: Method Requirements

// Mutating Method Requirements
protocol Togglable {
    mutating func toggle()
}

enum OnOffSwitch: Togglable {
    case off, on
    mutating func toggle() {
        switch self {
        case off:
            self = on
        case on:
            self = off
        }
    }
}
var lightSwitch = OnOffSwitch.off
lightSwitch.toggle()

// Initializer Requirements
protocol SomeProtocol {
    init()
}
class SomeSuperClass {
    init() {}
}
class SomeSubClass: SomeSuperClass, SomeProtocol {
    // "required" from SomeProtocol conformance; "override" from SomeSuperClass
    required override init() {
        // initializer implementation goes here
    }
}

// Protocols as Types 




// Delegation
// Delegation is a design pattern that enables a class or structure to hand off (delegate) some of its responsibilities to an instance of another type.
// This design apttern is implemented by defining a protocol that encapsulates the delegated responsibilities, such that a conforming type (known as a delegate) is guaranteed to provide the functionality that has been delegated.




// Adding Protocol Conformance with an Extension
protocol TextRepresentable {
    var textualDescription: String { get }
}

//extension Dice: TextRepresentable {
//    var textualDescription: String {
//        return "A \(sides)-sided dice"
//    }
//}

// Protocol Composition
protocol Named {
    var name: String { get }
}
protocol Aged {
    var age: Int { get }
}
struct BdayPerson: Named, Aged {
    var name: String
    var age: Int
}
func wishHappyBirthday(to celebrator: protocol<Named, Aged>) {
    print("Happy birthday, \(celebrator.name), you're \(celebrator.age)!")
}
let birthdayPerson = BdayPerson(name: "Malcolm", age: 21)
wishHappyBirthday(to: birthdayPerson)

protocol HasArea {
    var area: Double { get }
}

class Circle: HasArea {
    let pi = 3.1415927
    var radius: Double
    var area: Double  { return pi * radius * radius }
    init(radius: Double) { self.radius = radius }
}
class Country: HasArea {
    var area: Double
    init(area: Double) { self.area = area }
}
class Animal {
    var legs: Int
    init(legs: Int) { self.legs = legs }
}
let objects: [AnyObject] = [
    Circle(radius: 2.0),
    Country(area: 243_610),
    Animal(legs: 4)
]
for object in objects {
    if let objectWithArea = object as? HasArea {
        print("Area is \(objectWithArea.area)")
    } else {
        print("Something that doesn't have an area")
    }
}

// Optional Protocol Requirements
@objc protocol CounterDataSource {
    @objc optional func increment(forCount count: Int) -> Int
    @objc optional var fixedIncrement: Int { get }
}

class Counter {
    var count = 0
    var dataSource: CounterDataSource?
    func increment() {
        if let amount = dataSource?.increment?(forCount: count) {
            count += amount
        } else if let amount = dataSource?.fixedIncrement {
            count += amount
        }
    }
}

class ThreeSource: NSObject, CounterDataSource {
    let fixedIncrement = 3
}

var counter = Counter()
counter.dataSource = ThreeSource()
for _ in 1...4 {
    counter.increment()
    print(counter.count)
}
// 3 
// 6
// 9 
// 12

@objc class TowardsZeroSource: NSObject, CounterDataSource {
    func increment(forCount count: Int) -> Int {
        if count == 0 {
            return 0
        } else if count < 0 {
            return 1
        } else {
            return -1
        }
    }
}

counter.count = -4
counter.dataSource = TowardsZeroSource()
for _ in 1...5 {
    counter.increment()
    print(counter.count)
}

// Protocol Extensions







