//: Playground - noun: a place where people can play
import UIKit
import Foundation
import XCPlayground

XCPlaygroundPage.currentPage.needsIndefiniteExecution = true
// Swift Types
// 1. Named Types: struct, class, enum, protocol. It has a structure. structs are value type. classes are reference type. enum are sum type, you can specify an exact value. protocol binds everything together, it is a peer interface that your main types can conform to.
// 2. Compound type: function, tuple. Functions are first class types in swift, they are reference types. Tuples join up couple of types together.

// Reference Types: Only 2, classes and functions. Reference semantics maintained with ARC.
// Stack: the running memory for your program. data structure. LIFO. Do this by assigning an integer value. Each thread of execution in swift has its own stack. Structs are on the stack which is why its very fast.
// Heap: another data structure. Gotta release, do book keeping, 100x more work than moving a stack pointer. You can have a struct that stays on the heap.

// Is there an example of moving from the heap to the stack? When the compiler can rule out any sharing. It knows this object is being instantiated and remove in the scope. There's no need for it to stick around.

// Case where it has to be on the heap. You have a variable and use it in an async call (a closure) and your function returns but that closure is still active, still can be using that variable.

// Retain release with ARC (automatic reference counting)
// Pros: efficient, predictable, saves lots of typing
// Cons: you need to design the object graph such that there is not a circular reference

// Makes Swift a good language to write an OS, very predictable.

// Object Lifetime
class GameEngine {}
// strong reference: need to retain it by having a pointer to it. reference counts it. Strong reference, holding on it it, a retain. As soon as all the reference count go away, it gets deallocated. 99% of time compiler does the right thing for you

// weak reference: weak has to be optional type. unowned is another type, you dont have to optional type with unowned, it will trap it at runtime.

// Difference between strong and weak. Both can access and do operation. Strong keeps it alive, there is a strong pointer to it. Why use a weak variable? When you don't care if it's there or not.

// Circular References
// var child and var parent depend on each other. The parent owned the child. Make the parent weak var parent so it doesnt participate in the lifetime extension. the parent will deallocate and reference will go away and child will go away. Delegates you don't care if they are there or not, they used to be weak.

// use unowned so you can use uowned let parent. that way you dont have to use var parent?. var parent? because it can be a value or nil.

var method: () -> ()
// use self, leak!

// Escaping and non-escaping closures. By default everything was an escaping closure. It escapes the scope. If it escapes the scope you have to refer to self. If it is non-escaping, you dont have to refer to self.
// Make [weak weakSelf] to break the cycle

// autoclosure - not gonna run into it that much

// STRONG WEAK DANCE
class Person: CustomStringConvertible { // CustomStringConvertible returns "Frank" instead of "Person" on playground sidebar
    var name: String
    private(set) var pets: [Pet] = []
    init(name: String) {
        self.name = name
        print("Init \(name)")
    }
    deinit { // deinit is called right before it gets deallocated from memory. Structs has no deinits because they are value types, only classes.
        print("Deinit \(name)")
    }
    var description: String {
        return name
    }
    
    func add(pet: Pet) {
        pets.append(pet)
        pet.owner = self
    }
}
class Pet: CustomStringConvertible { // CustomStringConvertible returns "Frank" instead of "Person" on playground sidebar
    var name: String
    weak var owner: Person? // break cycle by putting weak. deinit gets called
    init(name: String) {
        self.name = name
        print("Init \(name)")
    }
    deinit { // deinit is called right before it gets deallocated from memory. Structs has no deinits because they are value types, only classes.
        print("Deinit \(name)")
    }
    var description: String {
        return name
    }
}
do { // need a scope to deinit, do this by using the "do" scope
    let frank = Person(name: "Frank")
    let munch = Pet(name: "Munch")
    //munch.owner = frank
    //frank.pets = [munch] // This creates a memory cycle and doesn't call deinit
    frank.add(munch)
}

// a pet can not have an owner (stray cat) therefore we call weak var owner: Person?



//closure captures

func foo() {
    var a = 1
    let b = 2
    let show: () -> Void = { [a,b] in //closure capture. short hand form of a = a, b = b. can use weak in closure capture as well
        print(a)
        print(b)
    }
    show()
    a += 1
    show()
}

foo()


// we want to pull data from google
class Fetcher {
    //let config = NSURLSessionConfiguration.defaultSessionConfiguration()
    init() { print("Inited!") }
    deinit {print("Deinited!")}
    var capturedData: NSData?
    
    let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
    func fetch () {
        let url = NSURL(string: "http://www.google.com")!
        
        let task = session.dataTaskWithURL(url) { [weak self] data, response, error in
            guard let strongSelf = self else {
                return
            }
            if let data = data {
                strongSelf.capturedData = data // so when we are not on the viewController anymore, we dont need to call this after the class gets deinited. Use this way so it doesnt check weak, for example, 4 times. strongSelf checks it once, all or nothing.
                //let string = NSString(data: data, encoding: NSASCIIStringEncoding)
                print("Success")
            }
        }
        task.resume() // async call.
    }
}

do {
    let f = Fetcher()
    f.fetch()
}













































