/*:
 [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
 ****
 # Initialization
 */

import Foundation



/// #Default Initializers

class ShoppingListItem {
    var name: String?
    var quantity = 1
    var purchased = false
    
    /// default initializer
    /// 满足条件：1、所有属性有默认值（包括optional）、2、没有自定义initializer
    /// default initializer实例化对象，使用Type的属性的默认值
//    init() {
//    }
    /// 自定义initailizer
    /// 如果自定义了initailizer后，default initializer就不起作用了，需要使用自定义的
//    init(name: String?, quantity: Int, purchased: Bool) {
//        self.name = name
//        self.quantity = quantity
//        self.purchased = purchased
//    }
}
let item = ShoppingListItem() //ShoppingListItem.init()

/// ##Memberwise Initializers for Structure Types

struct Size {
    var width = 0.0, height = 0.0
}



struct Point {
    var x = 0.0, y = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
    
    /// custom initializer
    /// 注意：
    /// 在Type里面自定义initializer，要采用给属性赋值的方式，不能调用memberwise或default initilizer；
    /// 使用Extension扩展initializer时，可以在自定义的initializer内调用memberwise或default initilizer
    /// 定义了
//    init() {}                           // same as default initializer
//
//    init(origin: Point, size: Size) {   // same as memberwise initializer
//        self.origin = origin
//        self.size = size
//    }
    
    init(center: Point, size: Size) {
        let originX = center.x - size.width / 2
        let originY = center.y - size.height / 2
        //self.init(center: Point.init(x: originX, y: originY), size: size) // 会无线循环
        //self.init(origin: Point.init(x: originX, y: originY), size: size) // 无法调用memberwise initilizer？？？
        self.origin = Point(x: originX, y: originY)
        self.size = size
    }
}

let defaultSize = Size() // Size.init()
let memberwiseSize = Size(width: 2.0, height: 2.0) // init(width:, height:)

/// default initializer
//let defaultRect = Rect()
/// memberwise initializer
//let memberwiseRect = Rect(origin: Point(x: 3.0, y: 3.0), size: Size(width: 4.0, height: 4.0))
/// 如果定义了custom initializer，default和memberwise initializer就不可用了
/// custom initializer
let customRect = Rect(center: Point(x: 5.0, y: 5.0), size: Size(width: 3.0, height: 3.0))



//: [Next](@next)
