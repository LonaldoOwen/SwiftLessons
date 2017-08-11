/*:
[Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
# Enumerations
*/
import Foundation
import UIKit

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



/// 应用实例

// Nested Enumerations

// 扩展CGSize，使其能用在enum中作为类型使用
extension CGSize: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        let size = CGSizeFromString(value)
        self.init(width: size.width, height: size.height)
    }
    public init(extendedGraphemeClusterLiteral value: String) {
        let size = CGSizeFromString(value)
        self.init(width: size.width, height: size.height)
    }
    public init(unicodeScalarLiteral value: String) {
        let size = CGSizeFromString(value)
        self.init(width: size.width, height: size.height)
    }
}

enum HelpEnum {
    
    enum Devices: CGSize {
        case iPhone4 = "{320, 480}"
        case iPhone5 = "{320, 568}"
        case iPhone6 = "{375, 667}"
        case iPhone6Plus = "{414, 736}"
    }
    
    enum Color {
        case myColor(Int)
        case systemColor(Int)
        init?(number: Int) {
            switch number {
            case 1:
                self = .myColor(1)
            default:
                self = .systemColor(0)
            }
        }

    }
    
    enum Font {
        case mySize11, mySize12
    }
}

//enum Mycolor: UIColor {
//    case one = UIColor.red
//    case two = UIColor.green
//}
let red = UIColor.red
let one = UIColor(red: 253/255.0, green: 253/255.0, blue: 253/255.0, alpha: 1.0)



var color = HelpEnum.Color.myColor(1)
var font = HelpEnum.Font.mySize11
var device = HelpEnum.Devices.iPhone4
print(color)
print(font.hashValue)
print(device.rawValue)


//: [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
