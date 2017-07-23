//: [Previous](@previous)
/*:
# NewWork
*/


import Foundation
import PlaygroundSupport



PlaygroundPage.current.needsIndefiniteExecution = true


///
let headers: [String: String] = [
    "Content-Type": "application/json",
    "seqnum": "0",
    "ver": "1.0",
    "uid": "498",
    "token": "nq4LWlvy7lJW-kh07fRRuDGeBwRvpnsJ0BGl17Xe4eeZEwvXwQN8HoBAluLmJbpQ",
]
let parameters = [
    "data": [
        "id": "46658"
    ]
]
let url = "http://test.api.fengchaoyou.com/v1/product/detail"

Network.request(method: "POST", url: url, headers: headers, parameters: parameters) { (data, response, error) in
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

//
Network.get(url: "http://music.163.com/#/my/m/music/playlist?id=781294334") { (data, response, error) in
    //
    print("response: \(response)")
    print("data: \(data)")
    PlaygroundPage.current.finishExecution()
}
//
Network.get(url: "http://music.163.com/#/my/m/music/playlist", headers: [:], parameters: ["id": "781294334", "name": "free", "type": "audio"]) { (data, response, error) in
    print("response: \(response)")
}










//: [Next](@next)
