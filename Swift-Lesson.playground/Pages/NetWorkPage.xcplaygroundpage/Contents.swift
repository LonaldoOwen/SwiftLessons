//: [Previous](@previous)
/*:
# NewWork
*/


import Foundation
import PlaygroundSupport



PlaygroundPage.current.needsIndefiniteExecution = true

/*
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
            //print("jsonData: \(String(describing: jsonData))")
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
*/

/*
// 请求公众号里的mp3文件
let mp3Url = "https://res.wx.qq.com/voice/getvoice?mediaid=MzIwMjg5Njg5N18yMjQ3NDg0Mjg1"
Network.get(url: mp3Url) { (data, response, error) in
    print("response: \(String(describing: response))")
}
*/

//
Network.get(url: "http://zentao.cct.cn/app/get-worst-all") { (data, response, error) in
    //
    print("response: \(String(describing: response))")
}







//: [Next](@next)
