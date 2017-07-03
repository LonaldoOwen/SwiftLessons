/*:
[Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
# Protocol
*/
import Foundation

var str = "Hello, playground"

// Declaring Protocol Adoption with an Extension
protocol TextRepresentable {
    var textualDescription: String { get }
}

struct Hamster {
    var name: String
    var textualDescription: String {
        return "A hamster named \(name)"
    }
}

extension Hamster: TextRepresentable {}

let simonTheHamster = Hamster(name: "simon")
print(simonTheHamster)
print(simonTheHamster.textualDescription)
let somethingTextRepresentable: TextRepresentable = simonTheHamster
print(somethingTextRepresentable.textualDescription)




/// 为什么Swift中的协议(protocol)采用的是“Associated Types”的方式来实现泛型功能的
/// 使用结构体，直接遵从协议
protocol Automobile {    // 机动车协议
    associatedtype FuelType
    associatedtype ExhaustType
    func drive(fuel: FuelType) -> ExhaustType
}
protocol Fuel {          // 燃料协议
    associatedtype ExhaustType
    func consume() -> ExhaustType
}
protocol Exhaust {       // 尾气协议
    init()
    func emit()
}

///
struct CleanExhaust: Exhaust {
    init() {}
    func emit() {
        print("...this is some clean exhaust...")
    }
}

struct UnleadedGasoline: Fuel {
    typealias ExhaustType = CleanExhaust
    func consume() -> CleanExhaust {
        print("...consuming unleaded gas...")
        return CleanExhaust()
    }
}

///
//
/*
class Car: Automobile {
    typealias FuelType = UnleadedGasoline
    typealias ExhaustType = CleanExhaust
    func drive(fuel: UnleadedGasoline) -> CleanExhaust {
        return fuel.consume()
    }
}
 */
//
class Car: Automobile {
    typealias FuelType = UnleadedGasoline
    //typealias ExhaustType = CleanExhaust
    func drive(fuel: UnleadedGasoline) -> UnleadedGasoline.ExhaustType {
        return fuel.consume()
    }
}

var car = Car()
//car.drive(fuel: UnleadedGasoline()).emit()
var fuelType = car.drive(fuel: UnleadedGasoline())
fuelType.emit()
// prints "...consuming unleaded gas..."
// prints "...this is some clean exhaust..."


/*
 ///
public protocol Automobile {
associatedtype FuelType
associatedtype ExhaustType
func drive(fuel: FuelType) -> ExhaustType
}
public protocol Fuel {
associatedtype ExhaustType
func consume() -> ExhaustType
}
public protocol Exhaust {
init()
func emit()
}

/// 使用结构体并增加Generic
public struct UnleadedGasoline<E: Exhaust>: Fuel {
    //public typealias ExhaustType = E
    public func consume() -> E {
    print("...consuming unleaded gas...")
        return E()
    }
}

public struct CleanExhaust: Exhaust {
    public init() {}
    public func emit() {
        print("...this is some clean exhaust...")
    }
}

//public class Car<F: Fuel,E: Exhaust>: Automobile
//    where F.ExhaustType == E {
//        public func drive(fuel: F) -> E {
//            return fuel.consume()
//        }
//}
//var fusion = Car<UnleadedGasoline<CleanExhaust>, CleanExhaust>()

///
public class Car<F: Fuel>: Automobile {
//public typealias FuelType = F
public func drive(fuel: F) -> F.ExhaustType { return fuel.consume() }
}

var fusion = Car<UnleadedGasoline<CleanExhaust>>()// fusion是福特（福特车英文名）
var unleadedGasoline = UnleadedGasoline<CleanExhaust>()
var cleanExhaust = fusion.drive(fuel: unleadedGasoline)
cleanExhaust.emit()
//fusion.drive(fuel: UnleadedGasoline<CleanExhaust>()).emit()
// prints "...consuming unleaded gas..."
// prints "...this is some clean exhaust..."
 */

/*
 /**
 * 问题：如何通过Generic和enum来实现汽车、燃料、尾气？？？
 */
 /// 定义协议
 protocol Automobile {
 associatedtype FuelType
 associatedtype ExhaustType
 func drive(fuel: FuelType) -> ExhaustType
 }
 protocol Fuel {
 associatedtype ExhaustType
 func consume() -> ExhaustType
 }
 protocol Exhaust {
 init?(fuelType: String)
 func emit()
 }
 
 /// 定义枚举，遵从协议
 enum ExhaustEnum: Exhaust {
 case cleanExhaust, unleadedExhaust, H2O
 // failable initializer
 init?(fuelType: String) {
 switch fuelType {
 case "cleanGas":
 self = .cleanExhaust
 case "unleadedGas":
 self = .unleadedExhaust
 case "naturalGas":
 self = .H2O
 default: return nil
 }
 }
 // 遵从Exhaust协议，实现里面定义的方法
 func emit() {
 switch self {
 case .cleanExhaust:
 print("Emit is some clean exhaust")
 case .unleadedExhaust:
 print("Emit is some unleaded exhaust")
 case .H2O:
 print("Emit is some H2O")
 }
 }
 }
 ExhaustEnum(fuelType:"cleanGas") // cleanExhaust
 ExhaustEnum(fuelType: "")        // nil
 ExhaustEnum.cleanExhaust         // cleanExhaust
 
 enum Gasoline<E: Exhaust>: Fuel {
 case cleanGas, unleadedGas
 // 遵循Fuel协议，实现定义的方法
 typealias ExhaustType = E
 func consume() -> E {
 switch self {
 case .cleanGas:
 print("Consuming clean gas")
 return E(fuelType: "cleanGas")!
 case .unleadedGas:
 print("Consuming unleaded gas")
 return E(fuelType: "unleadedGas")!
 }
 }
 }
 //let cleanGas = Gasoline<ExhaustEnum>.cleanGas
 //let cleanExhaust = cleanGas.consume()
 //cleanExhaust.emit()
 
 enum NaturalGas<E: Exhaust>: Fuel {
 case solidGas, liquidGas
 // 遵循Fuel协议，实现定义的方法
 func consume() -> E {
 switch self {
 default:
 print("Consuming natural gas")
 return E(fuelType: "naturalGas")!
 }
 }
 }
 
 /// 定义类，遵从协议并使用Generic
 class Car<F: Fuel>: Automobile {
 //public typealias FuelType = F
 func drive(fuel: F) -> F.ExhaustType { return fuel.consume() }
 }
 
 var cleanGas = Gasoline<ExhaustEnum>.cleanGas
 var gasCar = Car<Gasoline<ExhaustEnum>>()
 gasCar.drive(fuel: cleanGas).emit()
 // prints "Consuming clean gas"
 // prints "Emit is some clean exhaust"
 var unleadedGas = Gasoline<ExhaustEnum>.unleadedGas
 gasCar.drive(fuel: unleadedGas).emit()
 // prints "Consuming unleaded gas"
 // prints "Emit is some unleaded exhaust"
 var solidGas = NaturalGas<ExhaustEnum>.solidGas
 var naturalGasCar = Car<NaturalGas<ExhaustEnum>>()
 naturalGasCar.drive(fuel: solidGas).emit()
 // prints "Consuming natural gas"
 // prints "Emit is some H2O"
 */

/*
 这个使用if做判断的init?(term: String)有问题？？？
 */
//
enum Device {
    case AppleWatch
    init?(term: String) {
        if term == "iWatch" {
            print("get iWatch")
            self = .AppleWatch
        }
        return nil
        // 使用switch可以
        //        switch term {
        //            case "iWatch": self = .AppleWatch
        //            default: return nil
        //        }
    }
}
var device = Device(term: "iWatch")
//var device = Device(term: "")
//Device.AppleWatch

//: [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
