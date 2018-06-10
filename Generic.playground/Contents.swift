/*:
 [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
 ****
 # Generic
 */
import Foundation
import PlaygroundSupport




/// Generic



/// Generic Functions

func swapTwoValues<T>(_ a: inout T, _ b: inout T) {
    let temporaryA = a
    a = b
    b = temporaryA
}

var someInt = 3
var anotherInt = 107
swapTwoValues(&someInt, &anotherInt)
// someInt is now 107, and anotherInt is now 3

var someString = "hello"
var anotherString = "world"
swapTwoValues(&someString, &anotherString)
// someString is now "world", and anotherString is now "hello"


/*
/// Generic Types

// nongeneric version of a stack
// IntStack遵从Container协议时，注释掉此处
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
// Stack遵从Container协议时，注释掉此处
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
*/


/// Type Constraints

// The basic syntax for type constraints on a generic function is shown below (although the syntax is the same for generic types):
func someFunction<T: SomeClass, U: SomeProtocol>(someT: T, someU: U) {
    // function body goes there
}


// Type Constraints in Action

// Here’s a nongeneric function called findIndex(ofString:in:)
func findIndex(ofString valueToFind: String, in array: [String]) -> Int? {
    for (index, value) in array.enumerated() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}
let strings = ["cat", "dog", "llama", "parakeet", "terrapin"]
if let foundIndex = findIndex(ofString: "llama", in: strings) {
    print("The index of llama is \(foundIndex)")
}
// Prints"The index of llama is 2"

// Here’s how you might expect a generic version of findIndex(ofString:in:), called findIndex(of:in:), to be written.
// 这样写会提示编译错误；类型T并未实现“==”方法，因此，需要给类型T增加限制，让它遵从Equatable协议就可以了（Swift的standard type都遵从Equatable协议可以使用“==”方法）
//func findIndex<T>(of valueToFind: T, in array: [T]) -> Int? {
//    for (index, value) in array.enumerated() {
//        if value == valueToFind {
//            return index
//        }
//    }
//    return nil
//}
// Binary operator '==' cannot be applied to two 'T' operands

func findIndex<T: Equatable>(of valueToFind: T, in array: [T]) -> Int? {
    for (index, value) in array.enumerated() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}
let doubleIndex = findIndex(of: 9.3, in: [3.14159, 0.1, 0.25])
// doubleIndex is an optional Int with no value, because 9.3 isn't in the array
let stringIndex = findIndex(of: "Andrea", in: ["Mike", "Malcolm", "Andrea"])
// stringIndex is an optional Int containing a value of 2



/// # Associated Types


// Associated Types in Action

protocol Container {
    associatedtype Item // 声明Associated Type
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
}



// Here’s a version of the nongeneric IntStack type from Generic Types above, adapted to conform to the Container protocol:
 struct IntStack: Container {
    //original IntStack implementation
    var items = [Int]()                     //实例化一个数组，存储的是Int类型
    mutating func push(_ item: Int) {
        items.append(item)
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }

    //conformance to the Container protocol
    typealias Item = Int                    //inference by Swift
    mutating func append(_ item: Int) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Int {
        return items[i]
    }
 }

var intStack1 = IntStack()
intStack1.push(1)
intStack1.push(2)
//intStack1.push("3")       // 不支持String类型
intStack1.items
intStack1.pop()
intStack1.items
intStack1[0]                //

// after conforming to the Container protocol
intStack1.append(3)
intStack1[0]
intStack1.count

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


// Extending an Existing Type to Specify an Associated Type
// After defining this extension, you can use any Array as a Container.

let tempArray = Array<String>()
let tempDictionary = Dictionary<String, Any>()

//extension Array: Container {}


// Adding Constraints to an Associated Type
//protocol Container {
//    associatedtype Item: Equatable      // Adding Constraints to an Associated Type
//    mutating func append(_ item: Item)
//    var count: Int { get }
//    subscript(i: Int) -> Item { get }
//}
// To conform to this version of Container, the container’s Item type has to conform to the Equatable protocol.


// Using a Protocol in Its Associated Type’s Constraints
protocol SuffixableContainer: Container {
    associatedtype Suffix: SuffixableContainer where Suffix.Item == Item
    func suffix(_ size: Int) -> Suffix
}

extension Stack: SuffixableContainer {
    //typealias Suffix = Stack            //Inferred that Suffix is Stack.
    func suffix(_ size: Int) -> Stack {
        var result = Stack()
        for index in (count-size)..<count {
            result.append(self[index])
        }
        return result
    }
    // Inferred that Suffix is Stack.
}
var stackOfInts = Stack<Int>()
stackOfInts.append(10)
stackOfInts.append(20)
stackOfInts.append(30)
let suffix = stackOfInts.suffix(2)
// suffix contains 20 and 30

extension IntStack: SuffixableContainer {
    //typealias Suffix = Stack<Int>     //Inferred that Suffix is Stack<Int> .
    func suffix(_ size: Int) -> Stack<Int> {
        var result = Stack<Int>()
        for index in (count-size)..<count {
            result.append(self[index])
        }
        return result
    }
    // Inferred that Suffix is Stack<Int>.
}





/*
/// Generic Types
// Int Stack

struct IntStack {
    var items = [Int]() // 实例化一个数组，存储的是Int类型
    mutating func push(_ item: Int) {
        items.append(item)
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }
}
// extend an existing type to add conformance to a protocol
extension IntStack: Container {
    typealias Item = Int // inference by Swift
    mutating func append(_ item: Int) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Int {
        return items[i]
    }
    
}




// struct IntStack: Container {
//  original IntStack implementation
// var items = [Int]()  实例化一个数组，存储的是Int类型
// mutating func push(_ item: Int) {
// items.append(item)
// }
// mutating func pop() -> Int {
// return items.removeLast()
// }
//
//  conformance to the Container protocol
// typealias Item = Int  inference by Swift
// mutating func append(_ item: Int) {
// self.push(item)
// }
// var count: Int {
// return items.count
// }
// subscript(i: Int) -> Int {
// return items[i]
// }
// }


var intStack1 = IntStack()
intStack1.push(1)
intStack1.push(2)
//intStack1.push("3") // 不支持String类型
intStack1.items
intStack1.pop()
intStack1.items
//intStack1[0] // error

// after conforming to the Container protocol
intStack1.append(3)
intStack1[0]
intStack1.count


// Generic Stack

// struct Stack<Element> {
// var items = [Element]()
// mutating func push(_ item: Element) {
// items.append(item)
// }
// mutating func pop() -> Element {
// return items.removeLast()
// }
// }
//
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
    //typealias Item = Element // inference by Swift
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

var stackOfStrings = Stack<String>()
stackOfStrings.push("one")
stackOfStrings.push("two")
stackOfStrings.items
stackOfStrings.pop()
stackOfStrings.items
//stackOfStrings[0] // error

// after conforming to the Container protocol
stackOfStrings.append("Three")
stackOfStrings.count
stackOfStrings[1]

var stackOfInt = Stack<Int>()
stackOfInt.push(5)
stackOfInt.push(6)
stackOfInt.items
stackOfInt.pop()
stackOfInt.items

var stackOfFloat = Stack<Float>()
stackOfFloat.push(5.1)
stackOfFloat.push(6.3)

var stackOfDouble = Stack<Double>()
stackOfDouble.push(5.1)
stackOfDouble.push(6.3)


//
var arrayOfInt = [10, 20, 30]
arrayOfInt.append(40)
arrayOfInt.count
arrayOfInt[2]

// Array conform to Cantainer protocol
extension Array: Container {}


// Extending a Generic Type
extension Stack {
    var topItem: Element? {
        return items.isEmpty ? nil : items[items.count - 1]
    }
}

if let topItem = stackOfStrings.topItem {
    print("The top item on stack is \(topItem)")
}


/// Extensions with a Generic Where Clause
// extend a structure
extension Stack where Element: Equatable {
    func isTop(_ item: Element) -> Bool {
        guard let topItem = items.last else {
            return false
        }
        return topItem == item
    }
}
if stackOfStrings.isTop("one") {
    print("Top itme is one")
} else {
    print("Top item is something else")
}

// extend a protocol with where clause
extension Container where Item: Equatable {
    func startWith(_ item: Item) -> Bool {
        return count >= 1 && self[0] == item
    }
}
if [9, 9, 9].startWith(42) {
    print("Start with 42")
} else {
    print("Start with something else")
}

// extend a protocol with where clause which type to be a specific type
extension Container where Item == Double {
    func average() -> Double {
        var sum = 0.0
        for index in 0..<count {
            sum += self[index]
        }
        return sum / Double(count)
    }
}
[1280.0, 11.0, 100.0, 123.4].average()
[1.2, 2.2, 3.2].average()
[1, 2, 3.0].average()
//[1, 2, 3].append(4)
[1, 2, 3].average()
//stackOfInt.average()
//stackOfFloat.average()
stackOfDouble.average()


*/














//: [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)

