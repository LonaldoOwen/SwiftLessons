//: [Previous](@previous)
/*:
 
 
 */







import Foundation

var str = "Hello, playground"


// define protocol: Container
protocol Container {
    associatedtype Item // 声明Associated Type
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
}

// You can also make the generic Stack type conform to the Container protocol:
struct Stack<Element>: Container {
    // original Stack implementation
    var items = [Element]()
    mutating func push(_ item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
    
    // conformance to the Container protocol
    //typealias Item = Element                  // inference by Swift
    mutating func append(_ item: Element) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Element {
        return items[i]
    }
}


// ## Extending an Existing Type to Specify an Associated Type
extension Array: Container {}


// Container instance
var stackOfStrings = Stack<String>()
stackOfStrings.push("uno")
stackOfStrings.push("dos")
stackOfStrings.push("tres")


/*:
 Using a generic where clause lets you add a new requirement to the extension, so that the extension adds the isTop(_:) method only when the items in the stack are equatable.
 */
//
extension Stack where Element: Equatable {
    func isTop(_ item: Element) -> Bool {
        guard let topItem = items.last else {
            return false
        }
        return topItem == item
        // Binary operator '==' cannot be applied to two 'Element' operands
    }
}


// (Element=String)
if stackOfStrings.isTop("tres") {
    print("Top element is tres.")
} else {
    print("Top element is something else.")
}
// Prints "Top element is tres."


/*:
 If you try to call the isTop(_:) method on a stack whose elements aren’t equatable, you’ll get a compile-time error.
 */
struct NotEquatable { }
var notEquatableStack = Stack<NotEquatable>()
let notEquatableValue = NotEquatable()
notEquatableStack.push(notEquatableValue)
//notEquatableStack.isTop(notEquatableValue)  // Error
// Type 'NotEquatable' does not conform to protocol 'Equatable'


/*:
 You can use a generic where clause with extensions to a protocol. The example below extends the Container protocol from the previous examples to add a startsWith(_:) method.
 */
// extensions to a protocol (Item: Equatable)
// Item限定为遵从Equatable协议
extension Container where Item: Equatable {
    func startsWith(_ item: Item) -> Bool {
        return count >= 1 && self[0] == item
    }
}

/*:
 The startsWith(_:) method first makes sure that the container has at least one item, and then it checks whether the first item in the container matches the given item. This new startsWith(_:) method can be used with any type that conforms to the Container protocol, including the stacks and arrays used above, as long as the container’s items are equatable.
 */

if [9, 9, 9].startsWith(42) {
    print("Starts with 42.")
} else {
    print("Starts with something else.")
}
// Prints "Starts with something else."


/*:
 The generic where clause in the example above requires Item to conform to a protocol, but you can also write a generic where clauses that require Item to be a specific type. For example:
 */
// extensions to a protocol (Item == Double)
// Item限定为具体类型Double
extension Container where Item == Double {
    func average() -> Double {
        var sum = 0.0
        for index in 0..<count {
            sum += self[index]
        }
        return sum / Double(count)
    }
}
print([1260.0, 1200.0, 98.6, 37.0].average())
// Prints "648.9"

//stackOfStrings.aver
// Value of type 'Stack<String>' has no member 'aver'
//'String' is not convertible to 'Double'
// 只有遵从Container协议的类型满足Item==Double才能使用average()方法，stackOfStrings就无法使用




//: [Next](@next)
