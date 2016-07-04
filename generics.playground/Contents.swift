//: Playground - noun: a place where people can play

// generic allows us to avoid repetitive code because of type requirements

func printAnyArray<T>(anything: [T]) {
    for element in anything {
        print ("\(element)")
    }
}

printAnyArray(["ONE", "PUNCH", "MAN"])
printAnyArray([1, 2, 3])


func areTheyEqual<T: Equatable>(val1: T, val2: T) -> Bool {
    return val1 == val2
}

print(areTheyEqual("1", val2: "2"))

func compareThem<T: Comparable>(val1: T, val2: T) -> Bool {
    return val1 < val2
}
print(compareThem("a", val2: "b"))


// Generic Types
struct IntStack {
    var items = [Int]()
    mutating func push(item: Int) {
        items.append(item)
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }
}

struct Stack<Element> {
    var items = [Element]()
    mutating func push(item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
}

var stackOfStrings = Stack<String>()
stackOfStrings.push("uno")

var stackOfInts = Stack<Int>()

extension Stack {
    var topItem: Element? {
        return items.isEmpty ? nil : items[items.count - 1]
    }
}

// Type Constraints
// Dictionary's keys must be hashable. Hashable - making itself uniquely representable
protocol SomeProtocol {
    
}
class SomeClass {
    
}
func someFunction<T: SomeClass, U: SomeProtocol>(someT: T, someU: U) {
    // The hypothetical function above has two type parameters. The first type parameter, T, has a type constraint that requires T to be a subclass of SomeClass. The second type parameter, U, has a type constraint that requires U to conform to the protocol SomeProtocol
}

// Associated Types

protocol Container {
    associatedtype ItemType
    mutating func append(item: ItemType)
    var count: Int { get }
    subscript(i: Int) -> ItemType { get }
}

struct IntStack2: Container {
    // original IntStack implementation
    var items = [Int]()
    mutating func push(item: Int) {
        items.append(item)
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }
    // conformance to the Container protocol
    typealias ItemType = Int
    mutating func append(item: Int) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Int {
        return items[i]
    }
}
var japan = IntStack2(items: [1, 2, 3, 55, 33, 11])
japan.append(13)
japan.items
japan[1]
japan.count
japan.append(3)

struct Stack2<Element>: Container {
    // original IntStack implementation
    var items = [Element]()
    mutating func push(item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
    // conformance to the Container protocol
    mutating func append(item: Element) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Element {
        return items[i]
    }
}

extension Array: Container {} // Swift's Array type already provides an append(_:) method, a count property, and a subscript with an Int index to retrieve its elements. These 3 capabilities match the requirements of the Container protocol. This means that you can extend Array to conform to the Container protocol simply by declaring that Array adopts the protocol.


// Where Clauses
func allItemsMatch<C1: Container, C2: Container where C1.ItemType == C2.ItemType, C1.ItemType: Equatable>(someContainer: C1, anotherContainer: C2) -> Bool {
    // check that both containers contain the same number of items
    if someContainer.count != anotherContainer.count {
        return false
    }
    // check each pair of items to see if they are equivalent
    for i in 0..<someContainer.count {
        if someContainer[i] != anotherContainer[i] {
            return false
        }
    }
    
    // all items match, so return true
    return true
}

var stackOfStrings2 = Stack2<String>()
stackOfStrings2.push("uno")
stackOfStrings2.push("dos")
stackOfStrings2.push("tres")

var arrayOfStrings2 = ["uno", "dos", "tres"]

if allItemsMatch(stackOfStrings2, anotherContainer: arrayOfStrings2) {
    print("Matched.")
}



