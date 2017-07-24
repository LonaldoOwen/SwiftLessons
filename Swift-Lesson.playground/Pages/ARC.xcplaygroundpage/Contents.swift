/*:
 [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
 # Automatic Reference Counting
 * [LINK](http://chandao.cct.cn/index.php?m=bug&f=browse&productID=16&branch=0&browseType=all&param=0&orderBy=id_desc&recTotal=120&recPerPage=20)
 
 */

import Foundation

/*:
## How ARC Works
 
 
 
*/

/// How ARC Works

/// ARC in Action
class Person {
    let name: String
    init(name: String) {
        self.name = name
        print("\(name) is being initialized")
    }
    deinit {
        print("\(name) is being deinitialized")
    }
}

//var reference1: Person?
//var reference2: Person?
//var reference3: Person?
//
//reference1 = Person(name: "John Appleseed")
//reference2 = reference1
//reference3 = reference1
//
//reference1 = nil
//reference2 = nil
//reference3 = nil

var person: Person?

person = Person(name: "Mike")
person = Person(name: "Tom")





//: [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
