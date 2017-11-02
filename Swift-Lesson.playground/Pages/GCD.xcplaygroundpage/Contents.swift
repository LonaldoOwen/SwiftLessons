/*:
 [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
 # GCD
 
 */



import Foundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

// 
func simpleQueues() {
    let queue = DispatchQueue(label: "com.mirage.owen.simpleQueue")
    queue.async {
        for i in 0..<10 {
            print("🔴", i)
        }
    }
    for i in 100..<110 {
        print("Ⓜ️", i)
    }
//    print(DispatchQueue.main)
//    print(DispatchQueue.global())
//    print(queue)
}



/// 执行方法
simpleQueues()














//: [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
