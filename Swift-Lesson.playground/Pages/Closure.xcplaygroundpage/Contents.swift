/*:
[Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
# Closure
*/
import Foundation

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
// 显式写法（更易读）
//let closure = { () -> () in
//    a = 20      // by default,closure has a strong references to a and b
//    print(a, b)
//}
// 隐式写法（不易读，但更简洁）
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


/*:
 ## Trailing Closure
 If you need to pass a closure expression to a function as the function’s final argument and the closure expression is long, it can be useful to write it as a trailing closure instead. A trailing closure is written after the function call’s parentheses, even though it is still an argument to the function. When you use the trailing closure syntax, you don’t write the argument label for the closure as part of the function call.
 */

func someFunctionThatTakesAClosure(closure: () -> Void) {
    // function body goes here
}

// Here's how you call this function without using a trailing closure:

someFunctionThatTakesAClosure(closure: {
    // closure's body goes here
})

// Here's how you call this function with a trailing closure instead:

someFunctionThatTakesAClosure() {
    // trailing closure's body goes here
}


// map(_:)
let digitNames = [
    0: "Zero", 1: "One", 2: "Two",   3: "Three", 4: "Four",
    5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
]
let numbers = [16, 58, 510]

let strings = numbers.map {(number) -> String in
    var number = number
    var output = ""
    repeat {
        output = digitNames[number % 10]! + output
        number /= 10
    } while number > 0
    return output
}
// strings is inferred to be of type [String]
// its value is ["OneSix", "FiveEight", "FiveOneZero"]
 

//: [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
