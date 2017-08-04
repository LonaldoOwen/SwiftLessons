//: [Previous](@previous)

import Foundation



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











//: [Next](@next)
