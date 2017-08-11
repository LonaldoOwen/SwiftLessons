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




//: [Next](@next)
