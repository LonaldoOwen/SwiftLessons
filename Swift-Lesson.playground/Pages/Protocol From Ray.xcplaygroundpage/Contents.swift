/*:
[Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
# Protocols--from Ray

*/

import Foundation
import UIKit

/*:
 ## Introducing Protocol-Oriented Programming in Swift 3
*/
protocol Bird {
    var name: String { get }
    var canFly: Bool { get }
}
//
//protocol Bird: CustomStringConvertible {
//    var name: String { get }
//    var canFly: Bool { get }
//}

protocol Flyable {
    var airspeedVelocity: Double { get }
}

/*:
 ## Extensions
*/
extension Bird {
    // Flyable birds can fly!
    var canFly: Bool { return self is Flyable }
}

// Extending Protocols
//extension CustomStringConvertible where Self: Bird {
//    var description: String {
//        return canFly ? "I can fly" : "Guess I’ll just sit here"
//    }
//}

//extension Bird: CustomStringConvertible {
//    var description: String {
//        return ""
//    }
//}


///
struct FlappyBird: Bird, Flyable {
    let name: String
    let flappyAmplitude: Double // 振幅
    let flappyFrequency: Double // 频率
    //let canFly = true
    
    var airspeedVelocity: Double {
        return 3 * flappyFrequency * flappyAmplitude
    }
}

struct Penguin: Bird {
    let name: String
    //let canFly = false
}

struct SwiftBird: Bird, Flyable {
    var name: String { return "Swift\(version)" }
    let version: Double
    //let canFly = true
    
    // Swift is FASTER every version!
    var airspeedVelocity: Double { return version * 1000.0 }
}

let flappyBird = FlappyBird(name: "flappy", flappyAmplitude: 2.0, flappyFrequency: 3.0)
flappyBird.canFly

let penguin = Penguin(name: "penguin")
penguin.canFly

SwiftBird(version: 3.1).name
SwiftBird(version: 3.1).canFly

///
enum UnladenSwallow: Bird, Flyable {
    case african
    case european
    case unknown
    
    var name: String {
        switch self {
        case .african:
            return "African"
        case .european:
            return "European"
        case .unknown:
            return "What do you mean? African or European?"
        }
    }
    
    var airspeedVelocity: Double {
        switch self {
        case .african:
            return 10.0
        case .european:
            return 9.9
        case .unknown:
            fatalError("You are thrown from the bridge of death!")
        }
    }
}

UnladenSwallow.african.canFly
UnladenSwallow.african.name
UnladenSwallow.african.airspeedVelocity
UnladenSwallow.unknown.canFly

// Overriding Default Behavior
extension UnladenSwallow {
    var canFly: Bool {
        return self != .unknown
    }
}
UnladenSwallow.unknown.canFly
UnladenSwallow.european.canFly
SwiftBird(version: 3.1).canFly

UnladenSwallow.african
UnladenSwallow.unknown
Penguin(name: "Little Penguin")
SwiftBird(version: 3.1)


/*:
 ## Effects on the Swift Standard Library???
*/
let numbers = [10, 20, 30, 40, 50, 60]
let slice = numbers[1...3]
let reversedSlice = slice.reversed()

let answer = reversedSlice.map{$0 * 10}
print(answer)


///
class Motorcycle {
    init(name: String) {
        self.name = name
        speed = 200
    }
    var name: String
    var speed: Double
}

protocol Racer {
    var speed: Double { get }
}

extension FlappyBird: Racer {
    var speed: Double {
        return airspeedVelocity
    }
}

extension SwiftBird: Racer {
    var speed: Double {
        return airspeedVelocity
    }
}

extension Penguin: Racer {
    var speed: Double {
        return 42
    }
}

extension UnladenSwallow: Racer {
    var speed: Double {
        return canFly ? airspeedVelocity : 0
    }
}

extension Motorcycle: Racer{}

let racers: [Racer] =
    [UnladenSwallow.african,
     UnladenSwallow.european,
     UnladenSwallow.unknown,
     Penguin(name: "King Penguin"),
     SwiftBird(version: 3.1),
     FlappyBird(name: "Fellipe", flappyAmplitude: 3.1, flappyFrequency: 20.0),
     Motorcycle(name: "Giacomo")
]
print(racers)
print(racers[1...3])

//
//func topSpeed(of racers: [Racer]) -> Double {
//    return racers.max(by: {$0.speed < $1.speed})?.speed ?? 0
//}

//
//func topSpeed<RacerType: Sequence>(of racers: RacerType) -> Double
//    where RacerType.Iterator.Element == Racer {
//        return racers.max(by: {$0.speed < $1.speed})?.speed ?? 0
//}

//topSpeed(of: racers)
//topSpeed(of: racers[1...3]) // error

// more Swifty
extension Sequence where Iterator.Element == Racer {
    func topSpeed() -> Double {
        return self.max(by: {$0.speed < $1.speed})?.speed ?? 0
    }
}
racers.topSpeed()
racers[1...3].topSpeed()







//: [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
