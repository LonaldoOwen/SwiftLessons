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



/*:
 # Protocols--from The Swift Programming Language (Swift 3.1)
*/
print("// Protocols goes there")


/// Method Requirements
protocol RandomNumberGenerator {
    func random() -> Double
}

class LinearCongruentialGenerator: RandomNumberGenerator {
    var lastRandom = 42.0
    let m = 139968.0
    let a = 3877.0
    let c = 29573.0
    func random() -> Double {
        lastRandom = ((lastRandom * a + c).truncatingRemainder(dividingBy:m))
        return lastRandom / m
    }
}


/// Protocols as Types
//class Dice {
//    let sides: Int
//    let generator: RandomNumberGenerator
//    init(sides: Int, generator: RandomNumberGenerator) {
//        self.sides = sides
//        self.generator = generator
//    }
//    func roll() -> Int {
//        return Int(generator.random() * Double(sides)) + 1
//    }
//}
struct Dice {
    let sides: Int
    let generator: RandomNumberGenerator
    init(sides: Int, generator: RandomNumberGenerator) {
        self.sides = sides
        self.generator = generator
    }
    func roll() -> Int {
        return Int(generator.random() * Double(sides)) + 1
    }
}


/// Delegation
protocol DiceGame {
    var dice: Dice { get }
    func play()
}

protocol DiceGameDelegate {
    func gameDidStart(_ game: DiceGame)
    func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int)
    func gameDidEnd(_ game: DiceGame)
}

class SnakesAndLadders: DiceGame {
    let finalSquare = 25
    let dice = Dice(sides: 6, generator: LinearCongruentialGenerator())
    var square = 0
    var board: [Int]
    init() {
        board = Array(repeating: 0, count: finalSquare + 1)
        board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
        board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
    }
    var delegate: DiceGameDelegate?
    func play() {
        square = 0
        delegate?.gameDidStart(self)
        // Labeled Statements(这个while循环使用了Labeled Statements语法)
        gameLoop: while square != finalSquare {
            let diceRoll = dice.roll()
            delegate?.game(self, didStartNewTurnWithDiceRoll: diceRoll)
            switch square + diceRoll {
            case finalSquare:
                break gameLoop
            case let newSquare where newSquare > finalSquare:
                continue gameLoop
            default:
                square += diceRoll
                square += board[square]
            }
        }
        delegate?.gameDidEnd(self)
    }
}

class DiceGameTracker: DiceGameDelegate {
    var numberOfTurns = 0
    // 实现代理协议定义的方法
    func gameDidStart(_ game: DiceGame) {
        numberOfTurns = 0
        if game is SnakesAndLadders {
            print("Started a new game of Snakes and Ladders")
        }
        print("The game is using a \(game.dice.sides)-sided dice")
    }
    func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int) {
        numberOfTurns += 1
        print("Rolled a \(diceRoll)")
    }
    func gameDidEnd(_ game: DiceGame) {
        print("The game lasted for \(numberOfTurns) turns")
    }
}

let tracker = DiceGameTracker()
let game = SnakesAndLadders()
game.delegate = tracker
game.play()


/// Adding Protocol Conformance with an Extension
protocol TextRepresentable {
    var textualDescription: String { get }
}

extension Dice: TextRepresentable {
    var textualDescription: String {
        return "A \(sides)-sided dice"
    }
}

extension SnakesAndLadders: TextRepresentable {
    var textualDescription: String {
        return "A game of Snakes and Ladders with \(finalSquare) squares"
    }
}


/// Declaring Protocol Adoption with an Extension
struct Hamster {
    var name: String
    var textualDescription: String {
        return "A hamster named \(name)"
    }
}

extension Hamster: TextRepresentable {}

let simonTheHamster = Hamster(name: "simon")
simonTheHamster.textualDescription
simonTheHamster is TextRepresentable
//prints "false" // if not extend TextRepresentable protocol
//prints "true"  // after extend TextRepresentable protocol


/// Protocol Inheritance
print("// Protocol Inheritance goes there")
protocol PrettyTextRepresentable: TextRepresentable {
    var prettyTextualDescription: String { get }
}

extension SnakesAndLadders: PrettyTextRepresentable {
    var prettyTextualDescription: String {
        var output = textualDescription + ":\n"
        for index in 1...finalSquare {
            switch board[index] {
            case let ladder where ladder > 0:
                output += "▲ "
            case let snake where snake < 0:
                output += "▼ "
            default:
                output += "○ "
            }
        }
        return output
    }
}
print(game.prettyTextualDescription)
print(game.textualDescription)
game.board
/*
 1、继承协议和遵循协议是有区别的，继承是可以直接使用它的super的属性和方法；遵循要自己去实现协议的属性和方法的
 2、
 */


/// Checking for Protocol Conformance
print("// Checking for Protocol Conformance")
protocol HasArea {
    var area: Double { get }
}

class Circle: HasArea {
    let pi = 3.1415927
    var radius: Double
    var area: Double { return pi * radius * radius }
    init(radius: Double) { self.radius = radius }
}
class Country: HasArea {
    var area: Double
    init(area: Double) { self.area = area }
}

class Animal {
    var legs: Int
    init(legs: Int) { self.legs = legs }
}

let objects: [AnyObject] = [
    Circle(radius: 2.0),
    Country(area: 243_610),
    Animal(legs: 4)
]

for object in objects {
    if let objectWithArea = object as? HasArea {
        print("Area is \(objectWithArea.area)")
    } else {
        print("Something that doesn't have an area")
    }
}
// Area is 12.5663708
// Area is 243610.0
// Something that doesn't have an area


///
class MediaItem {
    var name: String
    init(name: String) {
        self.name = name
    }
}

class Movie: MediaItem {
    var director: String
    init(name: String, director: String) {
        self.director = director
        super.init(name: name)
    }
}

class Song: MediaItem {
    var artist: String
    init(name: String, artist: String) {
        self.artist = artist
        super.init(name: name)
    }
}

let library = [
    Movie(name: "Casablanca", director: "Michael Curtiz"),
    Song(name: "Blue Suede Shoes", artist: "Elvis Presley"),
    Movie(name: "Citizen Kane", director: "Orson Welles"),
    Song(name: "The One And Only", artist: "Chesney Hawkes"),
    Song(name: "Never Gonna Give You Up", artist: "Rick Astley")
]




//: [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
