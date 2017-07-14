/*:
[Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
# Statments
 
1、guard condition为true时，才会执行guard声明外的代码。

2、guard condition为false时，会执行else里面的代码；

3、else里通常要跟a control transfer statement such as return, break, continue, or throwor it can call a function or method that doesn’t return, such as fatalError(_:file:line:).
 
*/

import Foundation

/// Early Exit: gurad
/** 
 语法格式
guard confition else {
    statments
}
*/

// example1: return
func great(person: [String: String]) {
    guard let name = person["name"] else {
        return
    }
    print("Hello \(name)")
    
    guard let location = person["location"] else {
        print("I hope the weather is nice near you.")
        return
    }
    print("I hope the weather is nice in \(location).")
}

great(person: ["name": "John"])
great(person: ["name": "Jane", "location": "Captino"])
great(person: ["name": ""])

// example2: throw(见error handling)



//: [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
