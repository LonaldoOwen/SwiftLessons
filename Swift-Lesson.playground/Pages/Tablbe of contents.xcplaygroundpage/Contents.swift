//: Playground - noun: a place where people can play

/*:
- [Generic](Generic)
- [二级目录](Generic)
- [Protocol](Protocol)
- [Enumerations](Enumerations)
- [Associated Values](Associated%20Values)
- [Methods](Methods)
- [Protocol From Ray](Protocol%20From%20Ray)
- [MarkUp](MarkUp)
*/



/*:
Associated Values
*/
//它的意思是：定义一个枚举类型叫：Barcode，这个枚举有两个value：upc()和qrCode()，upc的关联类型是(Int,Int,Int,Int),qrCode的关联类型String



import UIKit

/// 请求url获取HTML源码
//URLCache.shared = URLCache(memoryCapacity: 0, diskCapacity: 0, diskPath: nil)
func request(httpUrl: String) {
    
    let url: NSURL = NSURL(string: httpUrl)!
    var request = URLRequest(url: url as URL)
    request.timeoutInterval = 10
    request.httpMethod = "GET"
    
    let configuration: URLSessionConfiguration = URLSessionConfiguration.default
    let session:URLSession = URLSession(configuration: configuration)
    let dataTask:URLSessionDataTask = session.dataTask(with: request) { (data, response, error) in
        if error != nil {
            print("error")
        } else {
            print("response:\(response)")
        }
    }
    dataTask.resume()
}
let urlString = "http://www.baidu.com"
request(httpUrl: urlString)







