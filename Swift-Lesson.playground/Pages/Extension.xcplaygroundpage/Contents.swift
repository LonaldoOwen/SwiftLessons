/*:
 [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
 ****
 # Extensions
 */

import Foundation


/// Computed Properties
extension Double {
    var km: Double { return self * 1_000.0 }    // Computed Properties
    var m: Double { return self }
    var cm: Double { return self / 100.0 }
    var mm: Double { return self / 1_000.0 }
    var ft: Double { return self / 3.28084 }
}
let oneInch = 25.4.mm
print("One Inch is \(oneInch) meters")
// Prints "One inch is 0.0254 meters"

let threeFeet = 3.ft
print("Three feet is \(threeFeet) meters")
// Prints Three feet is 0.914399970739201 meters

let aMarathon = 42.km + 195.m
print("A marathon is \(aMarathon) meters long")
// Prints A marathon is 42195.0 meters long


/// #Initializers


/// #Methods

// ##Mutating Instance Methods

/// #Subscripts

/// #Nested Types








//: [Next](@next)
