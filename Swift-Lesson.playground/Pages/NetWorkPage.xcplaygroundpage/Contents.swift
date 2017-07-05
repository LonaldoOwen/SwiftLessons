//: [Previous](@previous)
/*:
# NewWork
*/


import Foundation
import PlaygroundSupport



PlaygroundPage.current.needsIndefiniteExecution = true


/*
// 构造header
var header: [String: String] = ["Content-Type": "application/json", "seqnum": "0", "ver": "1.0", "uid": "498", "token": "nq4LWlvy7lJW-kh07fRRuDGeBwRvpnsJ0BGl17Xe4eeZEwvXwQN8HoBAluLmJbpQ", ]

// 构造httpBody
let json: [String: Any] = ["data": ["id": "46658"]]
let jsonData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)

// request
var request = URLRequest(url: URL(string: "http://test.api.fengchaoyou.com/v1/product/detail")!)
request.httpMethod = "POST"
request.allHTTPHeaderFields = header
request.httpBody = jsonData

// NSURLSession
//let config = URLSessionConfiguration.default
//let session = URLSession(configuration: config)
let session = URLSession.shared
let dataTask = session.dataTask(with: request) { (data, response, error) in
    //
    print("reponse: \(String(describing: response))")
    guard error == nil else {
        return
    }
    guard let data = data else {
        return
    }
    do {
        if let jsonData = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: AnyObject] {
            print("jsonData: \(String(describing: jsonData))")
        }
    } catch let error {
        print("error: \(error.localizedDescription)")
    }  

    PlaygroundPage.current.finishExecution()
}
dataTask.resume()
*/

/*
///
class Network {
    static func request(method: String, url: String, parameters: [String: Any], completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let manager = NetworkManager(url: url, method: method, parameters: parameters, completionHandler: completionHandler)
        manager.run()
    }
}


class NetworkManager {
    
    let method: String!
    let url: String!
    let parameters: [String: Any]
    
    let session: URLSession = URLSession.shared
    var dataTask: URLSessionTask!
    var request: URLRequest!
    let completionHandler: (Data?, URLResponse?, Error?) -> Void
    
    init (url: String, method: String, parameters: [String: Any], completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        self.url = url
        self.method = method
        self.parameters = parameters
        self.completionHandler = completionHandler
        self.request = URLRequest(url: URL(string: self.url)!)
    }
    
    func buildRequest() {
        let header: [String: String] = ["Content-Type": "application/json", "seqnum": "0", "ver": "1.0", "uid": "498", "token": "nq4LWlvy7lJW-kh07fRRuDGeBwRvpnsJ0BGl17Xe4eeZEwvXwQN8HoBAluLmJbpQ", ]
        request.httpMethod = self.method
        request.allHTTPHeaderFields = header
    }
    
    func buildBody() {
        request.httpBody = try? JSONSerialization.data(withJSONObject: self.parameters, options: .prettyPrinted)
    }
    
    func runTask() {
        dataTask = session.dataTask(with: request, completionHandler: { (data, response, error) in
            self.completionHandler(data, response, error)
        })
        dataTask.resume()
        //PlaygroundPage.current.finishExecution()
    }
    
    func run() {
        buildRequest()
        buildBody()
        runTask()
    }
}
*/


///
let parameters = [
    "data": [
        "id": "46658"
    ]
]
Network.request(method: "POST", url: "http://test.api.fengchaoyou.com/v1/product/detail", parameters: parameters) { (data, response, error) in
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
