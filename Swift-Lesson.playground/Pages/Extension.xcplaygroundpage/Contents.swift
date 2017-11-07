/*:
 [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
 ****
 # Extensions
 */

import Foundation

class SomeType {}

/// Extension Syntax
extension SomeType {
    // new functionality to add to SomeType goes here
}


/// Computed Properties
extension Double {
    // add Computed Properties
    var km: Double { return self * 1_000.0 }
    var m: Double { return self }
    var cm: Double { return self / 100.0 }
    var mm: Double { return self / 1_000.0 }
    var ft: Double { return self / 3.28084 }
}
let oneInch = 25.4.mm
print("One Inch is \(oneInch) meters")
// Prints "One inch is 0.0254 meters"

let threeFeet = 3.ft
print("Three feet is \(threeFeet) meters")
// Prints Three feet is 0.914399970739201 meters

let aMarathon = 42.km + 195.m
print("A marathon is \(aMarathon) meters long")
// Prints A marathon is 42195.0 meters long


/// #Initializers
struct Size {
    var width = 0.0, height = 0.0
}

struct Point {
    var x = 0.0, y = 0.0
}

struct Rect {
    var origin = Point()
    var size = Size()
}
// default initializer
let defaltRect = Rect()
// memberwise initializer
let memberwiseRect = Rect(origin: Point(x: 2.0, y: 2.0), size: Size(width: 5.0, height: 5.0))

// 扩展Rect，增加一个initializer
extension Rect {
    // add custom initializer
    init(center: Point, size: Size) {
        let originX = center.x - size.width/2
        let originY = center.y - size.height/2
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}

let centerRect = Rect(center: Point(x: 4.0, y: 4.0), size: Size(width: 3.0, height: 3.0))
// centerRect's origin is (2.5, 2.5) and its size is (3.0, 3.0)

/// 问题：
/// 1、class、enum、protocol是否支持？？？






/// #Methods
// Extensions can add new instance methods and type methods to existing types. The following example adds a new instance method called repetitions to the Int type:
extension Int {
    // add new instance mehtod
    func repetitions(task: () -> Void) {
        for _ in 0..<self {
            task() 
        }
    }
}

3.repetitions {
    print("Hello")
}

// ##Mutating Instance Methods
// Instance methods added with an extension can also modify (or mutate) the instance itself. Structure and enumeration methods that modify self or its properties must mark the instance method as mutating, just like mutating methods from an original implementation.

// The example below adds a new mutating method called square to Swift’s Int type, which squares the original value:
extension Int {
    // adds a new mutating method
    mutating func square() {
        self = self * self
    }
}
var someInt = 3
someInt.square()
// someInt is now 9


/// #Subscripts
extension Int {
    // add a subscript
    subscript(digitIndex: Int) -> Int {
        var decimalBase = 1
        for _ in 0..<digitIndex {   // if digitIndex=0,decimalBase = 1
            decimalBase *= 10
        }
        return (self / decimalBase) % 10
    }
}
746381295[0]
(746381295 / 1) % 10
// returns 5
746381295[1]
(746381295 / 10) % 10
// returns 9
// 如果请求的位数超出数字的总位数，会返回0，就好比在数字左侧添加0
746381295[9]
// returns 0, as if you had requested: 0746381295[9]


/// #Nested Types
// Extensions can add new nested types to existing classes, structures, and enumerations:
extension Int {
    // add new nested types:Kind
    enum Kind {
        case negative, zero, positive
    }
    // add a computed property:kind
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
func printIntegerKinds(_ numbers: [Int]) {
    for number in numbers {
        switch number.kind {
        case .negative:
            print("- ", terminator: "")
        case .zero:
            print("0 ", terminator: "")
        case .positive:
            print("+ ", terminator: "")
        }
    }
    print("")
}
printIntegerKinds([3, 19, -27, 0, -6, 0, 7])
// Prints "+ + - 0 - 0 + "
let a = 5
let b = 0
let c = -3
print("\(a.kind)")
print("\(b.kind)")
print("\(c.kind)")



//: [Next](@next)
