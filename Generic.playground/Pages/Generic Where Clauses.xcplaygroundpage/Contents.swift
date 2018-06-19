//: [Previous](@previous)
/*:
 ****
 # Generic Where Clauses
 
 ## 功能：define requirements for associated types
 A generic where clause enables you to require that an associated type must conform to a certain protocol, or that certain type parameters and associated types must be the same. \
 \
 理解：\
 1、要求an associated type必须遵从某个特定protocol（constraints for associated types）； \
 2、或者，特定type parameters和associated types必须一致（equality relationships between types and associated types）；
 
 \
 ## 语法：
 A generic where clause starts with the where keyword, followed by constraints for associated types or equality relationships between types and associated types. You write a generic where clause right before the opening curly brace of a type or function’s body.
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


// define a generic function: checks to see if two Container instances contain the same items in the same order
func allItemsMatch<C1: Container, C2: Container>
    (_ someContainer: C1, _ anotherContainer: C2) -> Bool
    where C1.Item == C2.Item, C1.Item: Equatable {
        
        // Check that both containers contain the same number of items.
        if someContainer.count != anotherContainer.count {
            return false
        }
        
        // Check each pair of items to see if they're equivalent.
        for i in 0..<someContainer.count {
            if someContainer[i] != anotherContainer[i] {
                return false
            }
        }
        
        // All items match, so return true.
        return true
}
/*:
 ## 函数解释：
 
 The following requirements are placed on the function’s two type parameters:
 
 - C1 must conform to the Container protocol (written as C1: Container).
 - C2 must also conform to the Container protocol (written as C2: Container).
 - The Item for C1 must be the same as the Item for C2 (written as C1.Item == C2.Item).
 - The Item for C1 must conform to the Equatable protocol (written as C1.Item: Equatable).
 - The first and second requirements are defined in the function’s type parameter list, and the third and fourth requirements are defined in the function’s generic where clause.
 
 These requirements mean:
 
 - someContainer is a container of type C1.
 - anotherContainer is a container of type C2.
 - someContainer and anotherContainer contain the same type of items.
 - The items in someContainer can be checked with the not equal operator (!=) to see if they’re different from each other.
 
 The third and fourth requirements combine to mean that the items in anotherContainer can also be checked with the != operator, because they’re exactly the same type as the items in someContainer.
 
 These requirements enable the allItemsMatch(_:_:) function to compare the two containers, even if they’re of a different container type.
 
 */

// Here’s how the allItemsMatch(_:_:) function looks in action:
// Container instance
var stackOfStrings = Stack<String>()
stackOfStrings.push("uno")
stackOfStrings.push("dos")
stackOfStrings.push("tres")

// Array
var arrayOfStrings = ["uno", "dos", "tres"]

// compare
if allItemsMatch(stackOfStrings, arrayOfStrings) {
    print("All items match.")
} else {
    print("Not all items match.")
}
// Prints "All items match."








//: [Next](@next)
