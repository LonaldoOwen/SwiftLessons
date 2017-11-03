/*:
[Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
****
# Generic
*/
import Foundation



/// Generic

// Type Constraints
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


// Associated Types
protocol Container {
    associatedtype Item // 声明Associated Type
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
}


// Generic Types
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


/*
struct IntStack: Container {
// original IntStack implementation
var items = [Int]() // 实例化一个数组，存储的是Int类型
mutating func push(_ item: Int) {
items.append(item)
}
mutating func pop() -> Int {
return items.removeLast()
}

// conformance to the Container protocol
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
*/

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
/*
struct Stack<Element> {
var items = [Element]()
mutating func push(_ item: Element) {
items.append(item)
}
mutating func pop() -> Element {
return items.removeLast()
}
}
*/
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

 
//: [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
