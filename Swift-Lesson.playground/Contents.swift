//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground;Swift, Lesson"

/*
/// Generic

// Type Constraints
func findIndex(ofString valueToFind: String, in array: [String]) -> Int? {
    for (index, value) in array.enumerated() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}
let strings = ["cat", "dog", "llama", "parakeet", "terrapin"]
if let foundIndex = findIndex(ofString: "llama", in: strings) {
    print("The index of llama is \(foundIndex)")
}
// Prints"The index of llama is 2"

func findIndex<T: Equatable>(of valueToFind: T, in array: [T]) -> Int? {
    for (index, value) in array.enumerated() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}
let doubleIndex = findIndex(of: 9.3, in: [3.14159, 0.1, 0.25])
// doubleIndex is an optional Int with no value, because 9.3 isn't in the array
let stringIndex = findIndex(of: "Andrea", in: ["Mike", "Malcolm", "Andrea"])
// stringIndex is an optional Int containing a value of 2




// Associated Types
protocol Container {
    associatedtype Item // 声明Associated Type
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
}


// Generic Types
// Int Stack

struct IntStack {
    var items = [Int]() // 实例化一个数组，存储的是Int类型
    mutating func push(_ item: Int) {
        items.append(item)
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }
}
// extend an existing type to add conformance to a protocol
extension IntStack: Container {
    typealias Item = Int // inference by Swift
    mutating func append(_ item: Int) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Int {
        return items[i]
    }

}


/*
struct IntStack: Container {
    // original IntStack implementation
    var items = [Int]() // 实例化一个数组，存储的是Int类型
    mutating func push(_ item: Int) {
        items.append(item)
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }
    
    // conformance to the Container protocol
    typealias Item = Int // inference by Swift
    mutating func append(_ item: Int) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Int {
        return items[i]
    }
}
*/

var intStack1 = IntStack()
intStack1.push(1)
intStack1.push(2)
//intStack1.push("3") // 不支持String类型
intStack1.items
intStack1.pop()
intStack1.items
//intStack1[0] // error

// after conforming to the Container protocol
intStack1.append(3)
intStack1[0]
intStack1.count


// Generic Stack
/*
struct Stack<Element> {
    var items = [Element]()
    mutating func push(_ item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
}
*/
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
    //typealias Item = Element // inference by Swift
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

var stackOfStrings = Stack<String>()
stackOfStrings.push("one")
stackOfStrings.push("two")
stackOfStrings.items
stackOfStrings.pop()
stackOfStrings.items
//stackOfStrings[0] // error

// after conforming to the Container protocol
stackOfStrings.append("Three")
stackOfStrings.count
stackOfStrings[1]

var stackOfInt = Stack<Int>()
stackOfInt.push(5)
stackOfInt.push(6)
stackOfInt.items
stackOfInt.pop()
stackOfInt.items

var stackOfFloat = Stack<Float>()
stackOfFloat.push(5.1)
stackOfFloat.push(6.3)

var stackOfDouble = Stack<Double>()
stackOfDouble.push(5.1)
stackOfDouble.push(6.3)


//
var arrayOfInt = [10, 20, 30]
arrayOfInt.append(40)
arrayOfInt.count
arrayOfInt[2]

// Array conform to Cantainer protocol
extension Array: Container {}


// Extending a Generic Type
extension Stack {
    var topItem: Element? {
        return items.isEmpty ? nil : items[items.count - 1]
    }
}

if let topItem = stackOfStrings.topItem {
    print("The top item on stack is \(topItem)")
}


/// Extensions with a Generic Where Clause
// extend a structure
extension Stack where Element: Equatable {
    func isTop(_ item: Element) -> Bool {
        guard let topItem = items.last else {
            return false
        }
        return topItem == item
    }
}
if stackOfStrings.isTop("one") {
    print("Top itme is one")
} else {
    print("Top item is something else")
}

// extend a protocol with where clause
extension Container where Item: Equatable {
    func startWith(_ item: Item) -> Bool {
        return count >= 1 && self[0] == item
    }
}
if [9, 9, 9].startWith(42) {
    print("Start with 42")
} else {
    print("Start with something else")
}

// extend a protocol with where clause which type to be a specific type
extension Container where Item == Double {
    func average() -> Double {
        var sum = 0.0
        for index in 0..<count {
            sum += self[index]
        }
        return sum / Double(count)
    }
}
[1280.0, 11.0, 100.0, 123.4].average()
[1.2, 2.2, 3.2].average()
[1, 2, 3.0].average()
//[1, 2, 3].append(4)
[1, 2, 3].average()
//stackOfInt.average()
//stackOfFloat.average()
stackOfDouble.average()




/// Protocol
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
*/
 


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




/*
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

/*
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
*/


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



//Array
//Dictionary
*/
 
 
 

/*
/// Closure
print("--Closure")

// capture list
print("--Capture List")
func logFunctionName(string: String = #function) {
    print(string)
}
func myFunction() {
    logFunctionName() // Prints "myFunction()".
}
myFunction()

// without using capture list
var a = 0
var b = 0
//let closure = { () -> () in
//    a = 20      // by default,closure has a strong references to a and b
//    print(a, b)
//}
let closure = {
    a = 20      // by default,closure has a strong references to a and b
    print(a, b)
}

a = 10
b = 10
closure()   // Prints "20 10"
print(a, b) // Prints "20 10"


// using capture list
var c = 0       // in the outer scope c is a variable
var d = 0
//let closureCaptureList = { [c] () -> () in
//    //c = 15    // in the inner scope c is a constant, got a error
//    print(c, d)
//}
let closureCaptureList = { [c] in
    //c = 15    // in the inner scope c is a constant, got a error
    print(c, d)
}

c = 10
d = 10
closureCaptureList() // Prints "0 10"
print(c, d)          // Prints "10 10"

// reference semantics
class SimpleClass {
    var value: Int = 0
}
var x = SimpleClass()
var y = SimpleClass()
let closureReference = { [x] in
    print(x.value, y.value)
}
x.value = 30
y.value = 30
closureReference() // Prints "30 30"
*/



/*
/// Methods
print("/// Methods")

// MARK--instance methods
class Counter {
    // property(store property)
    var count = 0
    // instance methods
    func increment() {
        count += 1
    }
    func increment(by amount: Int) {
        //count += amount
        // 一般方法参数名不和属性名形同时，不用使用self，相同时才需要使用，来进行区分
        self.count += amount
    }
    func reset() {
        count = 0
    }
}

let counter = Counter()
// the initial counter value is 0
counter.increment()
// the counter's value now is 1
counter.increment(by: 10)
// the counter's value now is 11
counter.reset()
// the counter's value now is 0


// The Self Property
// 在实例方法中，self代表实力本身，它是type的一个property
struct Point {
    var x = 0.0, y = 0.0
    func isToTheRightOf(x: Double) -> Bool {
        // 方法参数名和属性名相同，使用self.x来表示属性x
        return self.x > x
    }
}

let somePoint = Point(x: 4.0, y: 5.0)
if somePoint.isToTheRightOf(x: 1.0) {
    print("This point is to the right of the line where x == 1.0")
}
// Prints "This point is to the right of the line where x == 1.0"

// Modifying Value Types from Within Instance Methods
//struct SomePoint {
//    var x = 0.0, y = 0.0
//    mutating func moveBy(x deltaX: Double, y deltaY: Double) {
//        x += deltaX
//        y += deltaY
//    }
//}

// Assigning to self Within a Mutating Method
struct SomePoint {
    var x = 0.0, y = 0.0
    mutating func moveBy(x deltaX: Double, y deltaY: Double) {
        self = SomePoint(x: x + deltaX, y: y + deltaY)
    }
}


var pointOne = SomePoint(x: 1.0, y: 1.0)
var pointTwo = SomePoint(x: 2.0, y: 2.0)
pointOne.moveBy(x: 2.0, y: 3.0)
print("the point is now at \(pointOne.x, pointOne.y)")
// Points "the point is now at (3.0, 4.0)"

// NOTICE－－不能调用mutating方法修改constant of structure type
let fixedPoint = SomePoint(x: 4.0, y: 4.0)
//fixedPoint.moveBy(x: 2.0, y: 2.0)
//  this will report an error



// MARK--type methods
print("MARK--type methods")

struct LevelTracker {
    static var highestUnlockedLevel = 1
    var currentLevel = 1
    
    static func unlock (_ level: Int) {
        if level > highestUnlockedLevel {
            highestUnlockedLevel = level
        }
    }
    static func isUnlocked (_ level: Int) -> Bool {
        return level <= highestUnlockedLevel
    }
    
    @discardableResult
    mutating func advance (to level: Int) -> Bool {
        if LevelTracker.isUnlocked(level) {
            currentLevel = level
            return true
        } else {
            return false
        }
    }
}

class Player {
    var tracker = LevelTracker()
    let playerName: String
    
    func complete(level: Int) {
        LevelTracker.unlock(level + 1)
        tracker.advance(to: level + 1)
    }
    init(name: String) {
        playerName = name
    }
}

var player = Player(name: "Argryios")
player.complete(level: 1)
print("highest unlocked level is now \(LevelTracker.highestUnlockedLevel)")
// Prints "highest unlocked level is now 2"

player = Player(name: "Beto")
if player.tracker.advance(to: 6) {
    print("player is now on level 6")
} else {
    print("level 6 has not yet been unlocked")
}
*/



/// 正则表达式
print("/// 正则表达式")

// 构造正则工具
struct RegexHelper {
    let regex: NSRegularExpression?
    init(_ pattern: String) {
        //var error: NSError?
        regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive)
    }
    func match(input: String) -> Bool {
        if let matches = regex?.matches(in: input, options: NSRegularExpression.MatchingOptions(rawValue:0), range: NSMakeRange(0, input.characters.count)) {
            //
            for match in matches {
                print((input as NSString).substring(with: match.range))
            }
            
            print("matches:\(matches[0].range.length)")
            return matches.count > 0
        } else {
            return false
        }
        
    }
}

// 验证
let mailPattern = "^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$"
let matcher = RegexHelper(mailPattern)
let maybeMailAddress = "123446@qq.com"

if matcher.match(input: maybeMailAddress)
{
    print("有效的邮箱地址")
}
else
{
    print("无效的邮箱地址")
    
}

/// 请求url获取HTML源码
//URLCache.shared = URLCache(memoryCapacity: 0, diskCapacity: 0, diskPath: nil)
func request(httpUrl: String) {
    
    let url: NSURL = NSURL(string: httpUrl)!
    var request = URLRequest(url: url as URL)
    request.timeoutInterval = 10
    request.httpMethod = "GET"
    
    let configuration: URLSessionConfiguration = URLSessionConfiguration.default
    let session:URLSession = URLSession(configuration: configuration)
    let dataTask:URLSessionDataTask = session.dataTask(with: request) { (data, response, error) in
        if error != nil {
            print("error")
        } else {
            print("response:\(response)")
        }
    }
    dataTask.resume()
}
let urlString = "https://www.baidu.com"
request(httpUrl: urlString)







