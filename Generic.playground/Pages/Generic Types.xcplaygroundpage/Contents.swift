//: [Previous](@previous)
/*:
 # Generic Types
 */




import Foundation

/// Generic Types

// nongeneric version of a stack
struct IntStack {
    var items = [Int]()
    mutating func push(_ item: Int) {
        items.append(item)
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }
}

// generic version of the same code
struct Stack<Element> {
    var items = [Element]()
    mutating func push(_ item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
}

// For example, to create a new stack of strings, you write Stack<String>():
var stackOfStrings = Stack<String>()
stackOfStrings.push("uno")
stackOfStrings.push("dos")
stackOfStrings.push("tres")
stackOfStrings.push("cuatro")
// the stack now contains 4 strings

// Popping a value from the stack removes and returns the top value, "cuatro":
let fromTheTop = stackOfStrings.pop()
// fromTheTop is equal to "cuatro", and the stack now contains 3 strings




/*:
 # Extending a Generic Type
 */
/// Extending a generic type
// 扩展generic type时，不用提供type parameter list作为定义的一部分；
// 相反，原始的type parameter list在新的扩展body内是可见的；

extension Stack {
    // add a read-only computed property
    var topItem: Element? {
        return items.isEmpty ? nil : items[items.count - 1]
    }
}

if let topItem = stackOfStrings.topItem {
    print("The top item on the stack is \(topItem).")
}
// Prints "The top item on the stack is tres."








//: [Next](@next)
