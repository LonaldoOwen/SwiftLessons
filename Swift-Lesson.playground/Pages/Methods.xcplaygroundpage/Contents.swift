//: [Previous](@previous)

import Foundation

var str = "Hello, playground"


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
 

//: [Next](@next)
