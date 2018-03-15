/*:
 [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
 # Protocol from WWDC
 
 */



import Foundation
import UIKit


///
/*:
 # Protocol-Oriented Programming in Swift
 --WWDC 2015 - Session 408
 
 */
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





/*:
 # Building Better Apps with Value Types in Swift
 --WWDC 2015 - Session 414
 
 */




/*:
 ## References to Mutable Objects
 --Unexpected mutation
 
 */

// Helper




protocol Drawable {
    func draw()
}

// References to Mutable Objects
// Unexpected mutation
/*
struct BezierPath: Drawable {
    func draw() {
        // draw goes there
    }
    
    var path = UIBezierPath()
    
    var isEmpty: Bool {
        return path.isEmpty
    }
    
    func addLineToPoint(point: CGPoint) {
        //path.addlineToPoint(point)
        print("point: \(point)")
        path.addLine(to: point)
    }
}
var path = BezierPath()
var path2 = path
path.path
if path.isEmpty { print("Path is empty") }
path.addLineToPoint(point: CGPoint(x: 10, y: 20))
path.isEmpty
path2.isEmpty
// Note: path始终为空？？？

var tempPath1 = UIBezierPath()
tempPath1.isEmpty
tempPath1.addLine(to: CGPoint(x: 10, y: 20))
tempPath1.isEmpty

var tempPath2 = UIBezierPath(rect: CGRect(x: 0, y: 0, width: 10, height: 10))
tempPath2.isEmpty
tempPath2.addLine(to: CGPoint(x: 10, y: 20))
tempPath2.isEmpty
*/

struct BezierPath: Drawable {
    func draw() {
        // draw goes there
    }
    
    private var _path = UIBezierPath()
    
    var pathForReading: UIBezierPath {
        return _path
    }
    
    var pathForWriting: UIBezierPath {
        mutating get {
            _path = _path.copy() as! UIBezierPath
            return _path
        }
    }
}

extension BezierPath {
    func isEmpty() -> Bool {
        return pathForReading.isEmpty
    }
    
    mutating func addLineToPoint(point: CGPoint) {
        //pathForWriting.addLine(to: point) // Cannot use mutating getter on immutable value: 'self' is immutable
        //pathForWriting.move(to: point)
        
        if pathForWriting.isEmpty {
            pathForWriting.move(to: point)
        } else {
            pathForWriting.addLine(to: point)
        }
    }
}
var path = BezierPath()
var path2 = path
path.isEmpty()
path2.isEmpty()
path.pathForReading
path.pathForWriting

if path.isEmpty() { print("Path is empty") }
path.addLineToPoint(point: CGPoint(x: 10, y: 20))
path.addLineToPoint(point: CGPoint(x: 30, y: 40))
path.isEmpty()
path2.isEmpty()
path.pathForReading
path.pathForWriting
print(path.pathForReading)
print(path.pathForWriting)
withUnsafePointer(to: &path) { ptr in
    return ptr
}
withUnsafePointer(to: &path2) { ptr in
    return ptr
}






/*:
 ## copy-on-write(写时才复制)
 --赋值的时候，不分配内存；有写操作的时候才分配内存
 
 */
/// copy-on-write(写时才复制)
/// 赋值的时候，不分配内存；有写操作的时候才分配内存
///
var c: [Int] = [1, 2, 3]
c.withUnsafeBufferPointer { ptr  in
    return ptr
}
var d = c
d.withUnsafeBufferPointer { ptr in
    return ptr
}
// ptr(d) = ptr(c) （d: 未分配新内存地址）
d.append(4)
d.withUnsafeBufferPointer { ptr in
    return ptr
}
// ptr(d) = new ptr(d：分配新内存地址)


// 获取object的内存地址
// 自己的实现思路？？？（妈的，差距真大，在哪？？）
// 问题：Class类型用不了？？？；可以使用withUnsafeBufferPointer
//func address(of someArray: [Any]) -> UnsafeBufferPointer<Any> {
//    someArray.withUnsafeBufferPointer { (ptr in
//        return ptr
//    }
//}
// 别人的实现思路
func address(of object: UnsafeRawPointer) -> String {
    let addr = Int(bitPattern: object)
    return String(format: "%p", addr)
}
address(of: d)

/// object-reassignment in functions
/// Function parameters are constants by default.
/*
func append_one(_ a: [Int]) -> [Int] {
    a.append(1) // "Cannot use mutating member on immutable value: 'a' is a 'let' constant"
    return a
}
var a = [1, 2, 3]
a = append_one(a)
*/
// "Cannot use mutating member on immutable value: 'a' is a 'let' constant"

/// inplace mutation(through the usage of inout parameters)
///
func append_one_in_place(a: inout [Int]) {
    a.append(1)
}
var a = [1, 2, 3]
address(of: a)
append_one_in_place(a: &a)
address(of: a)





//: [Next](@next)
