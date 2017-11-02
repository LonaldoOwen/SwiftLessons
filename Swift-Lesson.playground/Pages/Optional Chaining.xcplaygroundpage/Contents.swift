/*:
 [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
 # Optional Chaining
 
*/

import Foundation



/// Optionals

let possibleNumber = "123"
let convertedNumber = Int(possibleNumber)
// convertedNumber is inferred to be of type "Int?", or "optional Int"

if convertedNumber != nil {
    print("convertedNumber has an integer value of \(convertedNumber!).")
}
// Prints "convertedNumber has an integer value of 123."


// Implicitly Unwrapped Optionals
let possibleString: String? = "An optional string."
let forcedString: String = possibleString!

let assumeString: String! = "An implicitly unwrapped optional string."
let implicitString: String = assumeString














//: [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
