/*:
 [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
 # NSPredicate
 
 */






import Foundation



/*:
 # NSPredicate
 
 
 */


/*:
 # Creating Predicates
 
 There are three ways to create a predicate in Cocoa: using a format string, directly in code, and from a predicate template.
 - using a format string
 - directly in code
 - from a predicate template
 */


/*:
 ## Creating a Predicate Using a Format String
 
 
 */

class Person:NSObject {
    @objc var firstName: String
    @objc var lastName: String
    @objc var age: Int
    @objc var birthday: Date
    
    init(firstName: String, lastName: String, age: Int, birthday: Date) {
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
        self.birthday = birthday
    }
}

let zhangsan = Person(firstName: "san", lastName: "zhang", age: 20, birthday: Date.init())
let lisi = Person(firstName: "si", lastName: "li", age: 30, birthday: Date())
let wangwu = Person(firstName: "wu", lastName: "wang", age: 40, birthday: Date())
let persons = [zhangsan, lisi, wangwu]


let lastNameSearchString = "abcd"
let birthdaySearchDate = Date()
//let predicate = NSPredicate(format: "lastName like[cd] %@ AND birthday > %@", lastNameSearchString, birthdaySearchDate as CVarArg)
let predicate = NSPredicate(format: "lastName like %@", lastNameSearchString)
// 报错：“error: Execution was interrupted, reason: signal SIGABRT.” ？？？
// 原因：NSPredicate应用需要满足object“class must be key-value coding compliant for the keys you want to use in a predicate.”
// 解决：Person继承NSObject，lastName增加@objc
let result = predicate.evaluate(with: zhangsan)

let zhangsanName = "zhangsan"
let zhangsanLastName = "zhang"
let cPredicate = NSPredicate(format: "%k like %@", zhangsan.lastName, zhangsanLastName)
let cResult = cPredicate.evaluate(with: zhangsan)

let bPredicate = NSPredicate(format: "SELF IN %@", ["Stig", "Shaffiq", "Chris"])
let bresult = bPredicate.evaluate(with: "Shaffiq")







//: [Next](@next)
