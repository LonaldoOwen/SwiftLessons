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
            //print("jsonData: \(String(describing: jsonData))")
        }
    } catch let error {
        print("error: \(error.localizedDescription)")
    }
    //
    PlaygroundPage.current.finishExecution()
}

let mp3Url = "https://res.wx.qq.com/voice/getvoice?mediaid=MzIwMjg5Njg5N18yMjQ3NDg0Mjg1"
//let request = URLRequest()
let session = URLSession.shared
let task = session.dataTask(with: URL(string: mp3Url)!) { (data, response, error) in
    //
    print("response: \(String(describing: response))")
    print("data: \(String(describing: data))")
}
task.resume()
    





//: [Next](@next)
