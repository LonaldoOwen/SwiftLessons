//: [Previous](@previous)

import Foundation
import UIKit


/// ceil,floor,round
// ceil: 返回大于或者等于指定表达式的最小整数

let a = 1 / 3
let b = 2 / 3
let c = 3 / 3

let d: Float = 1 / 3
let e: Float = 2 / 3
let f: Float = 3 / 3

let g = 1 / 3.0
let h = 2 / 3.0
let i = 3 / 3.0

let k: Float = 1 / 3.0
let l: Float = 2 / 3.0
let m: Float = 3 / 3.0

ceilf(1/3.0)
ceilf(2/3.0)
ceilf(3/3.0)

// 应用：计算单房差
// Android计算公式：
// bedprice = (float) ((Math.ceil((adultNum + childNum)/(float)details.beds_per_room)*details.beds_per_room - (adultNum + childNum))* details.bed_price);
// 使用ceil函数计算
func bedFree(forPersonNumber persons: Int, bedsPerRoom beds: Int) -> Int {
    let bedFree = ceilf(Float(persons) / Float(beds)) * Float(beds) - Float(persons)
    return Int(bedFree)
}
bedFree(forPersonNumber: 1, bedsPerRoom: 10)

// 根据模运算计算
func bedFreeByRemainder(forPersonNumber persons: Int, bedsPerRoom beds: Int) -> Int {
    var bedFree: Int = 0
    let mod: Int = persons % beds
    guard mod != 0 else {
        return 0
    }
    bedFree = beds - mod
    
    return bedFree
}

// numerator 被除数 denominator 除数 quotient 商 remainder 余数
bedFreeByRemainder(forPersonNumber: 1, bedsPerRoom: 3)
bedFreeByRemainder(forPersonNumber: 9, bedsPerRoom: 3)

/// iOS实现方式
//var bedNumber: Int {
//    if let bedsPerRoom = detail?.bedsPerRoom, bedsPerRoom != 0 {
//        let num = bedsPerRoom - totalNumber % bedsPerRoom
//        return num == bedsPerRoom ? 0 : num
//    }
//    return 0
//}
func bedFreForiOS(bedsPerRoom: Int?, totalNumber: Int) -> Int {
    if let bedsPerRoom = bedsPerRoom, bedsPerRoom != 0 {
        let num = bedsPerRoom - totalNumber % bedsPerRoom
        return num == bedsPerRoom ? 0 : num
    }
    return 0
}
let num = bedFreForiOS(bedsPerRoom: 2, totalNumber: 31)





/// protocol programing
/// 蜂巢CCTKit实现方式

final public class Proxy<Type> {
    
    let core: Type
    init(_ core: Type) {
        self.core = core
    }
    
}

public protocol CCTProxy {
    
    associatedtype ProxyType
    var cct: ProxyType { get }
    static var cct: ProxyType.Type { get }
    
}

public extension CCTProxy {
    
    public var cct: Proxy<Self> { return Proxy(self) }              // instance property
    public static var cct: ProxyType.Type { return ProxyType.self } // Type property
    
}

extension String: CCTProxy { }
extension UIView: CCTProxy { }

extension Proxy where Type == String {
    
    public func show() {
        //print(core)
        print("show: \(core)")
    }
}

extension Proxy where Type: UIView {
    public func showUIView() {
        print("showUIView: \(core)")
    }
}


let str = "abc"
print(str.cct)
print(str.cct.core)
str.cct.show()

let str2 = Proxy<String>.init("temp")
print(str2)
print(str2.core)
print(str2.show())
str2.core.cct

let someInt = Proxy<Int>.init(100)
print(someInt)
print(someInt.core)
print(String.cct)


let view = UIView()
print(view.cct)
print(view.cct.core)
print(view.cct.showUIView())
print(UIView.cct)



/// float 精度

// Float
// 这种直接计算进度会有问题
let fa: Float = 19999
let fc: Float = 123456.01
let sum: Float = fa + fc
print("sum: \(sum)")

// Double
let da: Double = 19999
let dc: Double = 123456.01
let dSum: Double = da + dc

// Decimal
let decimalA: Decimal = 19999
let decimalC: Decimal = 123456.01
let decimalSum: Decimal = decimalA + decimalC

// NSDecimalNumber
let ndA: NSDecimalNumber = NSDecimalNumber(string: "19999")
let ndC: NSDecimalNumber = NSDecimalNumber(string: "123456.01")
let ndSum: NSDecimalNumber = ndA.adding(ndC)



/// Data 转 String

let string1 = "string1"
let data1 = string1.data(using: String.Encoding.utf8)
let string2 = String.init(data: data1!, encoding: String.Encoding.utf8)

// image -> JPEG data -> string
let image = UIImage.init(named: "加号")
let pngData = UIImagePNGRepresentation(image!)
// ???
let pngContent = String.init(data: pngData!, encoding: String.Encoding.utf8)

// image -> JPEG data -> base64 string
let base64String = pngData?.base64EncodedString()
let base64Data = Data.init(base64Encoded: base64String!)

let utf8Data = base64String?.data(using: .utf8)
//let tempString = String.init()



//
let path = Bundle.main.path(forResource: "", ofType: ".png")
let fileContent = try? String.init(contentsOfFile: path!, encoding: String.Encoding.utf8)




var body: NSMutableData = NSMutableData()
body.append(data1!)
body.append(pngData!)


/// array add object of type IndexPath
/// 注意：Swift里面并未介绍如何使用optional类型的数组；因此创建数组不要用optional，可以先创建空数组

// 定义optional类型数组
//var indexPathToInsert: [IndexPath]!
//let indexPath = IndexPath.init(row: 0, section: 1)
//indexPathToInsert?.append(indexPath)
// Result: indexPathToInsert = nil

//var indexPathToInsert: [IndexPath]!
//let indexPath = IndexPath.init(row: 0, section: 1)
//indexPathToInsert!.append(indexPath)
// Result: 报错“fatal error: unexpectedly found nil while unwrapping an Optional value”

// 定义数组变量，并初始化为空数组
var indexPathToInsert: [IndexPath] = []
let indexPath = IndexPath.init(row: 0, section: 1)
indexPathToInsert.append(indexPath)




/// Range、NSRange

let passwordPool = "AaBbCc12345"
for char in passwordPool {
    print(char)
}
print(passwordPool.startIndex)
print(passwordPool.endIndex)
let randomIndex = 4
let index = passwordPool.index(passwordPool.startIndex, offsetBy: randomIndex)
let char = passwordPool[index]
let subString = String(char)
print("index: \(index)")
print("char: \(char)")
print("substring: \(subString)")


/// Date、DateFormatter
var now = Date.init(timeIntervalSinceNow: 0)
let formater = DateFormatter.init()
//formater.dateStyle = .medium
//formater.timeStyle = .short
formater.locale = NSLocale.init(localeIdentifier: "zh_CN") as Locale!
formater.setLocalizedDateFormatFromTemplate("yyyy-MM-dd HH:mm:ss")
let str1 = formater.string(from: now)
print(str1)


/// 面试题
/// 求一个string中各字母出现的次数
let appleString = "apple"

// 方法1: 使用enumerated()
var dictionary1 = [String: Int]()
for (index, char) in appleString.enumerated(){
    print("char: \(char), index: \(index)")
    if dictionary1["\(char)"] == nil {
        dictionary1["\(char)"] = 1
    } else {
        dictionary1["\(char)"] = dictionary1["\(char)"]! + 1
    }
}
print("current dic: \(dictionary1)")
for (index, element) in dictionary1.enumerated() {
    print("index: \(index), element: \(element)")
    print("\(element.key): \(element.value)")
}

// 方法2: 使用charactor
var dictonary2 = [String: Int]()
for charactor in appleString {
    print(charactor)
    let numbers = dictonary2["\(charactor)"]
    if numbers == nil {
        dictonary2["\(charactor)"] = 1
    } else {
        dictonary2["\(charactor)"] = numbers! + 1
    }
}
print("dic2: \(dictonary2)")





//: [Next](@next)
