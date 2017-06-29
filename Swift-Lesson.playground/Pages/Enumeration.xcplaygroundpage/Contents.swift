//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

/// Enumerations
print("/// Enumerations")

// 枚举的可失败构造器（failable initializer）init?(symbol: Character)
// 下例中，定义了一个名为TemperatureUnit的枚举类型。其中包含了三个可能的枚举成员(Kelvin，Celsius，和 Fahrenheit)和一个被用来找到Character值所对应的枚举成员的可失败构造器：
enum TemperatureUnit {
    case kelvin, celsius, fahrenheit
    init?(symbol: Character) {
        switch symbol {
        case "K":
            self = .kelvin
        case "C":
            self = .celsius
        case "F":
            self = .fahrenheit
        default:
            return nil
        }
    }
}
let fahrenheitUnit = TemperatureUnit(symbol: "F")
if fahrenheitUnit != nil {
    print("This is a defined temperature unit, so initialization succeeded.")
}
// Prints "This is a defined temperature unit, so initialization succeeded."

let unknownUnit = TemperatureUnit(symbol: "X")
if unknownUnit == nil {
    print("This is not a defined temperature unit, so initialization failed.")
}

TemperatureUnit.kelvin
TemperatureUnit.celsius


/**
 enumeraton的基本定义和使用
 */
// 定义（使用enum关键字，使用case关键字来引出新的枚举情况）
enum CompassPoint {
    case north
    case south
    case east
    case west
}

// 只用一个case，将所有的情况写在一行
enum Planet {
    case mercury, venus, earth, mars, jupiter, saturn, uranus, neptune
}

// 使用点语法来使用cases
var directionToHead = CompassPoint.west
directionToHead = .east

// 使用swith声明来匹配每种枚举的情况
directionToHead = .south
switch directionToHead {
case .north:
    print("Lots of planets have a north")
case .south:
    print("Watch out for penguins")
case .east:
    print("Where the sun rises")
case .west:
    print("Where the skies are blue")
}

directionToHead = .north
// Prints "Watch out for penguins"
/**
 * 为什么下面的语句不打印对应的描述？？？
 * 原因：上面的switch只执行了一次，directionToHead = .north之后不回再回去执行前面的switch了
 * 解决：将switch放在function里面，这样每次调用函数都回调用switch
 */
func manageDirection(directionToHead: CompassPoint) {
    switch directionToHead {
    case .north:
        print("Lots of planets have a north")
    case .south:
        print("Watch out for penguins")
    case .east:
        print("Where the sun rises")
    case .west:
        print("Where the skies are blue")
    }
}
manageDirection(directionToHead: .east)
manageDirection(directionToHead: .north)

// 单独匹配
directionToHead = .north
if case .north = directionToHead {
    print("North")
}
if case .south = directionToHead {
    print("South")
}

directionToHead = .east
if directionToHead == .east {
    print("East")
}

// 使用default来代表所有其他情况
let somePlanet = Planet.earth
switch somePlanet {
case .earth:
    print("Mostly harmless")
default:
    print("Not a safe place for humans")
}
// Prints "Mostly harmless"


 var sum: Int = 0
 sum = 3
 switch sum {
 case 1: print("1")
 case 2: print("2")
 case 3: print("3")
 default: print("others")
 }
 sum = 2
 sum = 3
 
 func manageSwitch(sum: Int) {
 switch sum {
 case 1: print("1")
 case 2: print("2")
 case 3: print("3")
 default: print("others")
 }
 }
 manageSwitch(sum: 2)
 manageSwitch(sum: 3)
 

//: [Next](@next)
