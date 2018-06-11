//: [Previous](@previous)

import Foundation

var str = "Hello, playground"


/*:
 # Generic Protocols
 */

/// type relationships（Abstract types）

// define protocol: Automobile（汽车）
protocol Automobile {
    associatedtype FuelType
    associatedtype ExhaustType
    func drive(fuel: FuelType) -> ExhaustType
}

// define protocol: Fuel（燃料）
protocol Fuel {
    associatedtype ExhaustType
    func consume() -> ExhaustType
}

// define protocol: Exhaust（尾气）
protocol Exhaust {
    init()
    func emit()     // 排出（尾气）
}


/// type relationships（Concrete types）

// define structure：无铅汽油
struct UnleadedGasoline<E: Exhaust>: Fuel {
    public func consume() -> E {
        print("...consuming unleaded gas...")
        return E()
    }
}
// define structure：清洁尾气
struct CleanExhaust: Exhaust {
    public init() {}
    public func emit() {
        print("...this is some clean exhaust...")
    }
}

// define Class：Car（generic type）
/*
class Car<F: Fuel, E: Exhaust>: Automobile where F.ExhaustType == E {
    func drive(fuel: F) -> E {
        //return fuel.consume() as! E（不使用where clause）
        return fuel.consume()
    }
}
var fusion = Car<UnleadedGasoline<CleanExhaust>, CleanExhaust>()
fusion.drive(fuel: UnleadedGasoline<CleanExhaust>()).emit()
// Print
//...consuming unleaded gas...
//...this is some clean exhaust...
*/

// 优化上面的Car定义（尾气可由汽油决定，因此可以不用限制尾气）
class Car<F: Fuel>: Automobile {
    func drive(fuel: F) -> F.ExhaustType {
        return fuel.consume()
    }
}
var fusion = Car<UnleadedGasoline<CleanExhaust>>()
fusion.drive(fuel: UnleadedGasoline<CleanExhaust>()).emit()
// Print
//...consuming unleaded gas...
//...this is some clean exhaust...















//: [Next](@next)
