//: [Previous](@previous)
/*:
# NewWork
*/


import Foundation
import PlaygroundSupport



PlaygroundPage.current.needsIndefiniteExecution = true


///
let parameters = [
    "data": [
        "id": "46658"
    ]
]
let url = "http://test.api.fengchaoyou.com/v1/product/detail"
Network.request(method: "POST", url: url, parameters: parameters) { (data, response, error) in
    //
    do {
        if let jsonData = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: AnyObject] {
            print("jsonData: \(String(describing: jsonData))")
        }
    } catch let error {
        print("error: \(error.localizedDescription)")
    }
    //
    PlaygroundPage.current.finishExecution()
}




//: [Next](@next)
