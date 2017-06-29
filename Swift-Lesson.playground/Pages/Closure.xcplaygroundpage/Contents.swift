//: [Previous](@previous)

import Foundation

var str = "Hello, playground"


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
 

//: [Next](@next)
