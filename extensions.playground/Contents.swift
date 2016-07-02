//: Playground - noun: a place where people can play

import Foundation
import UIKit

extension String {
    var asArray: [Character] {
        var result = [Character]()
        
        for char in self.characters {
            result.append(char)
        }
        return result
    }
    
    func letterOccurrence(theChar: Character) -> Int {
        var numOfChars = 0
        
        for letter in self.characters {
            if letter == theChar {
                numOfChars += 1
            }
        }
        return numOfChars
    }
}

var characters = "A random string".asArray

print(characters)



var numberOfAs: Int = "a random string".letterOccurrence("a")
print(numberOfAs)



extension Double {
    var km: Double { return self * 1_000.0 }
    var m: Double { return self }
    var cm: Double { return self / 100.0 }
    var mm: Double { return self / 1_000.0 }
    var ft: Double { return self / 3.28084 }
}

let oneInch = 25.4.mm
print("One inch is \(oneInch) meters")
// Prints "One Inch is 0.0254 meters"
let threeFeet = 3.ft
print("Three feet is \(threeFeet) meters")
// Prints "Three feet is 0.9143999807 meters"

//NOTE: Extensions can add new computed properties, but they cannot add stored properties, or add property observers to existing properties
// Initializers: Extensions can add new convenience initializers to a class, but cannot add new designated initializers or deinitializers to a class

struct Size {
    var width = 0.0, height = 0.0
}
struct Point {
    var x = 0.0, y=0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
}
let defaultRect = Rect()
let memberwiseRect = Rect(origin: Point(x: 2.0, y: 2.0), size: Size(width: 5.0, height: 5.0))

// Methods 
extension Int {
    func repetitions(task: () -> Void) {
        for _ in 0..<self {
            task()
        }
    }
}

3.repetitions { 
    print("hello!")
}

// Mutating Instance Methods
extension Int {
    mutating func square() {
        self = self * self
    }
}

var someInt = 3
someInt.square()
someInt

// Subscripts
extension Int {
    subscript(digitIndex: Int) -> Int {
        var decimalBase = 1
        for _ in 0..<digitIndex {
            decimalBase *= 10
        }
        return (self / decimalBase) % 10
    }
}

7412354[0]
33234112[1]
123123421[2]
1231[11]

// Nested Types 
extension Int {
    enum Kind {
        case negative, zero, positive
    }
    var kind: Kind {
        switch self {
        case 0:
            return .zero
        case let x where x > 0:
            return .positive
        default:
            return .negative
        }
    }
}

func printIntegerKinds(numbers: [Int]) {
    for number in numbers {
        switch number.kind {
        case .negative:
            print("- ", terminator: "")
        case .zero:
            print("0 ", terminator: "")
        default:
            print("+ ", terminator: "")
        }
    }
    print("")
}
printIntegerKinds([3, 12, 34, -55, 3, 0, 11, -9, 0])










