//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

/**
 Associated Values
 */
//它的意思是：定义一个枚举类型叫：Barcode，这个枚举有两个value：upc()和qrCode()，upc的关联类型是(Int,Int,Int,Int),qrCode的关联类型String
enum Barcode {
    case upc(Int, Int, Int, Int)
    case qrCode(String)
}

var productBarcode = Barcode.upc(8, 85909, 51226, 3)
productBarcode = Barcode.qrCode("ABCDEFGHIJKLMNOP")

//使用switch来匹配枚举值
switch productBarcode {
case .upc(let numberSystem, let manufacturer, let product, let check):
    print("UPC: \(numberSystem), \(manufacturer), \(product), \(check).")
case .qrCode(let productCode):
    print("QR code: \(productCode).")
}
// Prints "QR code: ABCDEFGHIJKLMNOP."

//上面的变形（如果：关联值都是constant或variable，则可以使用下面的形式，把let或var放在case name前面）
switch productBarcode {
case let .upc(numberSystem, manufacturer, product, check):
    print("UPC : \(numberSystem), \(manufacturer), \(product), \(check).")
case let .qrCode(productCode):
    print("QR code: \(productCode).")
}
// Prints "QR code: ABCDEFGHIJKLMNOP."


/**
 Raw Value
 */
// 定义stores raw ASCII values alongside named enumeration cases:
enum ASCIIControlCharacter: Character {
    case tab = "\t"
    case lineFeed = "\n"
    case carriageReturn = "\r"
}
ASCIIControlCharacter.tab.hashValue
ASCIIControlCharacter.tab.rawValue
ASCIIControlCharacter.lineFeed.hashValue
ASCIIControlCharacter.lineFeed.rawValue

// Implicitly Assigned Raw Values
// raw value类型为Int时，如果没明确给出默认值，那么下一个默认比上一个大1
enum PlanetRaw: Int {
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
}
PlanetRaw.mercury
PlanetRaw.mercury.rawValue
PlanetRaw.mars
PlanetRaw.mars.rawValue

// 如果枚举的默认值类型为Int，第一个case没有明确给出值，那么它的默认值为：0
enum DefaultFirstRaw: Int {
    case zero, one, two = 2, three
}
DefaultFirstRaw.zero
DefaultFirstRaw.zero.rawValue
DefaultFirstRaw.one
DefaultFirstRaw.one.rawValue

// string作为raw value，它的默认值就是cases name本身
enum CompassPointRaw: String {
    case north, south, east, west
}
CompassPointRaw.north
CompassPointRaw.north.rawValue

// Initializing from a Raw Value
let possiblePlanet = PlanetRaw(rawValue: 7)
// possiblePlanet is of type Planet? and equals Planet.uranus

//Recursive Enumerations
//enum ArithmeticExpression {
//    case number(Int)
//    indirect case addition(ArithmeticExpression, ArithmeticExpression)
//    indirect case multiplication(ArithmeticExpression, ArithmeticExpression)
//}

indirect enum ArithmeticExpression {
    case number(Int)
    case addition(ArithmeticExpression, ArithmeticExpression)
    case multiplication(ArithmeticExpression, ArithmeticExpression)
}

let five = ArithmeticExpression.number(5)
let four = ArithmeticExpression.number(4)
let sum = ArithmeticExpression.addition(five, four)
let product = ArithmeticExpression.multiplication(sum, ArithmeticExpression.number(2))
print(product)

func evaluate(_ expression: ArithmeticExpression) -> Int {
    switch expression {
    case let .number(value):
        return value
    case let .addition(left, right):
        return evaluate(left) + evaluate(right)
    case let .multiplication(left, right):
        return evaluate(left) * evaluate(right)
    }
}

print(evaluate(product))
// Prints "18"


//enum Device {
//    case iPad, iPhone, AppleTV, AppleWatch
////    func introduced() -> String {
////        switch self {
////        case .AppleTV: return "\(self) was introduced 2006"
////        case .iPhone: return "\(self) was introduced 2007"
////        case .iPad: return "\(self) was introduced 2010"
////        case .AppleWatch: return "\(self) was introduced 2014"
////        }
////    }
//    var desription: String {
//        switch self {
//        case .AppleTV: return "\(self) was introduced 2006"
//        case .iPhone: return "\(self) was introduced 2007"
//        case .iPad: return "\(self) was introduced 2010"
//        case .AppleWatch: return "\(self) was introduced 2014"
//        }
//    }
//
//}
////print (Device.iPhone.introduced())
//print(Device.iPad.desription)

//: [Next](@next)
