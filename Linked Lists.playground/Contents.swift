import Foundation

// Linked Lists

public class LinkedListNode<T> {
    var value: T
    var next: LinkedListNode?
    weak var previous: LinkedListNode?
    
    public init(value: T) {
        self.value = value
    }
}

public class LinkedList<T> {
    public typealias Node = LinkedListNode<T>
    
    private var head: Node?
    
    public var isEmpty: Bool {
        return head == nil
    }
    
    public var first: Node? {
        return head
    }
    
    public var last: Node? {
        //        same as:
        //        var node: Node? = head
        //        while node != nil && node!.next != nil {
        //            node = node!.next
        //        }
        if var node = head {
            while case let next? = node.next { // loops until the last node
                node = next
            }
            return node
        } else {
            return nil
        }
    }
    
    public func append(value: T) {
        let newNode = Node(value: value)
        if let lastNode = last {
            newNode.previous = lastNode
            lastNode.next = newNode
        } else {
            head = newNode
        }
    }
    
    public var count: Int {
        if var node = head {
            var c = 1
            while case let next? = node.next {
                node = next
                c += 1
            }
            return c
        } else {
            return 0
        }
    }
    
    public func nodeAtIndex(index: Int) -> Node? {
        if index >= 0 {
            var node = head
            var i = index
            while node != nil {
                if i == 0 { return node }
                i -= 1
                node = node?.next
            }
        }
        return nil
    }
    
    public subscript(index: Int) -> T {
        let node = nodeAtIndex(index)
        assert(node != nil)
        return node!.value
    }
    
    private func nodesBeforeAndAfter(index: Int) -> (Node?, Node?) {
        assert(index >= 0)
        
        var i = index
        var next = head
        var prev: Node?
        
        while next != nil && i > 0 {
            i -= 1
            prev = next
            next = next?.next
        }
        // assert() after the loop checks whether there really were enough nodes in the list. if i > 1 at this point, then the specified index was too large
        assert(i == 0)
        
        return (prev, next)
    }
    
    public func insert(value: T, atIndex index: Int) {
        let (prev, next) = nodesBeforeAndAfter(index)
        
        let newNode = Node(value: value)
        newNode.previous = prev
        newNode.next = next
        prev?.next = newNode
        next?.previous = newNode
        
        if prev == nil {
            head = newNode
        }
    }
    
    public func removeAll() {
        head = nil
        // if theres a tail pointer, set it to nil here too
    }
    
    public func removeNode(node: Node) -> T {
        let prev = node.previous
        let next = node.next
        
        if let prev = prev {
            prev.next = next
        } else {
            head = next
        }
        next?.previous = prev
        
        node.previous = nil
        node.next = nil
        return node.value
    }
    
    public func removeLast() -> T {
        assert(!isEmpty)
        return removeNode(last!)
    }
    
    public func removeAtIndex(index: Int) -> T {
        let node = nodeAtIndex(index)
        assert(node != nil)
        return removeNode(node!)
    }
    
    public func reverse() {
        var node = head
        while let currentNode = node {
            node = currentNode.next
            swap(&currentNode.next, &currentNode.previous)
            head = currentNode
        }
    }
    
    public func map<U>(transform: T -> U) -> LinkedList<U> {
        let result = LinkedList<U>()
        var node = head
        while node != nil {
            result.append(transform(node!.value))
            node = node!.next
        }
        return result
    }
    
    public func filter(predicate: T -> Bool) -> LinkedList<T> {
        let result = LinkedList<T>()
        var node = head
        while node != nil {
            if predicate(node!.value) {
                result.append(node!.value)
            }
            node = node!.next
        }
        return result
    }
}

extension LinkedList: CustomStringConvertible {
    public var description: String {
        var s = "["
        var node = head
        while node != nil {
            s += "\(node!.value)"
            node = node!.next
            if node != nil {
                s += ", "
            }
        }
        return s + "]"
    }
}

// Alternative value semantics
enum ListNode<T> {
    indirect case Node(T, next: ListNode<T>)
    case End
}



let list = LinkedList<String>()
list.isEmpty
list.first
list.append("Hello")
list.isEmpty
list.first?.value
list.last?.value

list.append("World")
list.first?.value
list.last?.value

//                        +---------+        +---------+
//       head --->|                |--->|                 |---> nil
//                        | "Hello" |       | "World" |
//            nil <---|               |<---|                 |
//                        +---------+        +---------+

list.first?.previous
list.first?.next?.value
list.last?.previous?.value
list.head

list.nodeAtIndex(0)?.value
list.nodeAtIndex(1)?.value
list.nodeAtIndex(2)

list.insert("Swift", atIndex: 1)
list[0]
list[1]
list[2]

// Note: If any of the loops in this article don't make much sense to you, then draw a linked list on a piece of paper and step through the loop by hand, just like what we did here.

list.removeNode(list.first!)
list.count
list[0]
list[1]

list.removeLast()
list.count
list[0]

list.removeAtIndex(0)
list.count

list.append("Hello")
list.append("Kitty")
list.description



















































