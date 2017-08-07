/*:
 [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
# Collection Types
 
 */





import Foundation



/// Array

/// Creating an Empty Array

var someInts = [Int]()  // using initializer
print("someInts is of type [Int] with \(someInts.count) items.")
someInts.append(3)

someInts = []           // using empty array literal[]
print(someInts.isEmpty)

// Creates an array containing the elements of a sequence.
let numbers = Array(1...7)
print("numbers is of type [Int] with \(numbers.count) items.")


/// Creating an Array with a Default Value
// Creates a new array containing the specified number of a single, repeated value.
let fiveZs = Array(repeating: "Z", count: 5)
print(fiveZs)


/// Creating an Array by Adding Two Arrays Together
let sixAs = Array(repeating: "A", count: 3)
let eightStings = fiveZs + sixAs

/// Creating an Array with an Array Literal
var shoppingList: [String] = ["Eggs", "Milk"]


/// Accessing and Modifying an Array

// count
print("The shopping list contains \(shoppingList.count) items.")

// isEmpty
if shoppingList.isEmpty {
    print("The shoppingList is empty")
} else {
    print("The shoppingList is not empty")
}

// append(_:)
shoppingList.append("Flour")

// (+=)
shoppingList += ["Baking Powder"]
shoppingList += ["Chocolate Spread", "Cheese", "Butter"]

// subscript syntax, rertieve item
var firstItem = shoppingList[0]

// change item
shoppingList[0] = "Six Eggs"
print(shoppingList)

// change a range of items
shoppingList[4...6] = ["Bananas", "Apples"]
print(shoppingList)

// insert(_:at:)
shoppingList.insert("Maple Syrup", at: 0)
print(shoppingList)

// remove(at:), removeLast()
let mapleSyrup = shoppingList.remove(at: 0)
print(shoppingList)

firstItem = shoppingList[0]
let apples = shoppingList.removeLast()
print(shoppingList)


/// Iterating Over an Array(迭代)

for item in shoppingList {
    if item == "Flour" {
        //return        // 不可用
        //break           // 可用
        continue        // 可用
    }
    print("for-in: \(item)")
}

// forEach(_:)
shoppingList.forEach { (item) in
    if item == "Flour" {
        //return        // 可用
        //break           // 不可用
        //continue        // 不可用
    }
    print("forEach: \(item)")
}

for (index, value) in shoppingList.enumerated() {
    print("\(index): \(value)")
}


/// other properies and methods
print(shoppingList.count)
print(shoppingList.capacity)
shoppingList.debugDescription
shoppingList.endIndex               // = count - 1
shoppingList.startIndex             // = 0
shoppingList.customMirror           // ???
print(shoppingList.customMirror)
shoppingList.indices
shoppingList.lazy                   // ???怎么用
shoppingList.underestimatedCount    // ???

someInts = [1, 2, 3, 4, 5]
let lastItem = someInts.popLast()           // 从someInts中删除最后一个item
someInts.distance(from: 1, to: 3)           //

let dropFirst = someInts.dropFirst()        // 返回一个不包含first的新数组，原数组不变
let dropLast = someInts.dropLast()      // 返回一个不包含last的新数组，原数组不变
let dropLastTwo = someInts.dropLast(2)     // 返回一个不包含最后n个的新数组，原数组不变
print(someInts)

var anotherInts = [6, 7, 8, 9, 2]
if someInts.elementsEqual(anotherInts) {    // 比较两个数组是否一样
    print("true")
} else {
    print("false")
}

/// filter(_:)  
/// Returns an array containing, in order, the elements of the sequence that satisfy the given predicate.
/// 返回满足条件的数组
var filteritems = someInts.filter({ (element) -> Bool in
    element < 3
})
filteritems = someInts.filter {
    $0 == 2
}

/// first(where:) 
/// Returns the first element of the sequence that satisfies the given predicate or nil if no such element is found.
/// 返回满足条件的第一个item或者nil
let filterFirst = anotherInts.first { (item) -> Bool in
    item > 7
}


// formIndex(_:offsetBy:)???
var a = 3
var b = 5
someInts.formIndex(&a, offsetBy: 2)


/// index(of:) 
/// Returns the first index where the specified value appears in the collection.
/// 返回第一个满足所给元素的索引值
var students = ["Ben", "Ivy", "Jordell", "Maxime"]
if let i = students.index(of: "Maxime") {
    students[i] = "Max"
}
print(students)


/// index(where:) 
/// Returns the first index in which an element of the collection satisfies the given predicate.
/// 返回第一个满足断言的元素的索引值
students = ["Kofi", "Abena", "Peter", "Kweku", "Akosua"]
if let i = students.index(where: { $0.hasPrefix("A") }) {
    print("\(students[i]) starts with 'A'!")
}


/// joined(separator:) 
/// Returns a new string by concatenating the elements of the sequence, adding the given separator between each element.
///返回一个String，将序列中的元素串联起来，使用一个符号隔开，
let cast = ["Vivien", "Marlon", "Kim", "Karl"]
let list = cast.joined(separator: "-->")
print(list)

// ???在数组中插入数组并串联在一起
let nestedNumbers = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
let joined = nestedNumbers.joined(separator: [-1, -2])
print(joined)
print(Array(joined))


/// map(_:) （映射）
/// Returns an array containing the results of mapping the given closure over the sequence’s elements.
///返回一个新数组，根据closure里的变化，原数组中的元素根据规则一一转换为新的元素
let lowercaseNames = cast.map { $0.lowercased() }
print(lowercaseNames)
let letterCounts = cast.map { $0.characters.count }
print(letterCounts)

struct DataModel {
    let name: String
    let index: String
}

//let dataModels = cast.map { (item) -> DataModel in
//    DataModel(
//        name: item,
//        index: cast.index(of: item) // 报错？？？？
//    )
//}

// 在map中要获取Array的index，使用Array.enumerated().map {}
//var dataModels = cast.enumerated().map { (index, value) -> DataModel in
//    DataModel(
//        name: value,
//        index: String(index)
//    )
//}
// 上面的形式的简单写法
//dataModels = cast.enumerated().map {
//    DataModel(
//        name: $1,
//        index: String($0)
//    )
//}

// Xcode9
var dataModels = cast.enumerated().map { (arg) -> DataModel in
    
    let (index, value) = arg
    return DataModel(
        name: value,
        index: String(index)
    )
}
// 上面的形式的简单写法
// Xcode9, 编译报错
//dataModels = cast.enumerated().map {
//    DataModel(
//        name: $1,
//        index: String($0)
//}


/// flatMap<ElementOfResult>((Element) -> ElementOfResult?)
/// Returns an array containing the non-nil results of calling the given transformation with each element of this sequence.
/// 返回包含non-nil的数组
let possibleNumbers = ["1", "2", "three", "///4///", "5"]
var mapped: [Int?] = possibleNumbers.map { str in Int(str) }
print(mapped)
let flatMapped: [Int] = possibleNumbers.flatMap { str -> Int? in Int(str) }
print(flatMapped)
//[nil, nil, nil, nil, nil]
//[]

/// flatMap<SegmentOfResult>((Element) -> SegmentOfResult)
/// Returns an array containing the concatenated results of calling the given transformation with each element of this sequence.
///返回一个数组，结果是closure的结果串联起来的数组
let anotherMapped = someInts.map { Array(repeating: $0, count: 3) }
print(anotherMapped)
let anotherFlatMapped = someInts.flatMap { Array(repeating: $0, count: 3) }
print(anotherFlatMapped)



/// max()
/// Returns the maximum element in the sequence.
/// 返回序列中最大的元素

let heights = [67.5, 65.7, 64.3, 61.1, 58.5, 60.3, 64.9]
let greatestHeight = heights.max()
// min()
let lowestHeight = heights.min()

// 如果序列是String类型，根据字母顺序、大写、小写等顺序进行比较，
let someStrings = ["b", "aaaa", "Fsb", "Fs", "Bbb", "Ccc", "Aaaf", "Franch"]
let greatestItem = someStrings.max()
let lowestItem = someStrings.min()  // 如果是








//: [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
