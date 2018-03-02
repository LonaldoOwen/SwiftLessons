/*:
 [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
 # Protocols--from Ray
 
 */



import Foundation


///
/*
class Ordered {
    func precedes(other: Ordered) -> Bool { fatalError("implement me!") }
}

//class Number: Ordered {
//    var value: Double = 0
//    override func precedes(other: Ordered) -> Bool {
//        return value < other.value    // error
//    }
//}
// Note: "Value of type 'Ordered' has no member 'value'"

class Number: Ordered {
    var value: Double = 0
    override func precedes(other: Ordered) -> Bool {
        return value < (other as! Number).value
    }
}
*/

// 使用Protocol实现
// 创建Ordered协议，定义precedes()方法
//protocol Ordered {
//    func precedes(other: Ordered) -> Bool { fatalError("implement me!") }
//}
// Note: "Protocol methods may not have bodies"（协议中的方法，不需要函数体）

//protocol Ordered {
//    func precedes(other: Ordered) -> Bool
//}

/*:
 ## Protocols with Self requirement
 The type for function parameters can be marked as Self. When this is done, the type is automatically resolved to the type of the conforming object.
 
 Protocols with self won’t work in the following cases though:
 - Properties of type Self aren’t allowed. (I’m unable to find any documentation for this though — this just doesn't compile, when I tried. But when you think of it, the use-case for this is pretty limited — how often do you have one type owning an instance of the same type?)
 - if Self is the return type of a function.
 
 ## Associated Types
 When using Self, there is only one generic type possible — the conforming type itself. Instead, it’s also possible to declare one or more associatedtypes inside the protocol. An associated type is a type that can be filled in later by the conforming type. Inside the protocol, it is just a declaration — It is upto the conforming type to define what that associatedtype is.
 */

protocol Ordered {
    func precedes(other: Self) -> Bool
}

//struct Number: Ordered {
//    var value: Double = 0
//    func precedes(other: Ordered) -> Bool {
//        return value < (other as! Number).value
//    }
//}

//
//struct Number: Ordered {
//    var value: Double = 0
//    func precedes(other: Number) -> Bool {
//        return value < other.value
//    }
//}
// Note: "Type 'Number' does not conform to protocol 'Ordered'"

// 修改precedes()参数类型为：Self，
struct Number: Ordered {
    var value: Double = 0
    func precedes(other: Number) -> Bool {
        return value < other.value
    }
}


// using protocols

//func binarySearch(sortedKeys: [Ordered], forKey k: Ordered) -> Int { //
//    var lo = 0
//    var hi = sortedKeys.count
//    while hi > lo {
//        let mid = lo + (hi - lo) / 2
//        if sortedKeys[mid].precedes(other: k) { lo = mid + 1 }
//        else { hi = mid }
//    }
//    return lo
//}
// Note: "Protocol 'Ordered' can only be used as a generic constraint because it has Self or associated type requirements"

// 调整为Generic类型
func binarySearch<T: Ordered>(sortedKeys: [T], forKey k: T) -> Int { //
    var lo = 0
    var hi = sortedKeys.count
    while hi > lo {
        let mid = lo + (hi - lo) / 2
        if sortedKeys[mid].precedes(other: k) { lo = mid + 1 }
        else { hi = mid }
    }
    return lo
}
var number1 = Number(value: 2)
var number2 = Number(value: 4)
var number3 = Number(value: 6)
var number4 = Number(value: 8)
binarySearch(sortedKeys: [number1, number2, number3, number4], forKey: number4)







//: [Next](@next)
