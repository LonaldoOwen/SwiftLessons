//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground;Swift, Lesson"


/*:
/// Generic
*/

/*:
/// Protocol
*/

/*:
/// Enumerations
*/

/*:
Associated Values
*/
//它的意思是：定义一个枚举类型叫：Barcode，这个枚举有两个value：upc()和qrCode()，upc的关联类型是(Int,Int,Int,Int),qrCode的关联类型String

/*:
Raw Value
*/
// 定义stores raw ASCII values alongside named enumeration cases:

/*:
//Array
//Dictionary
*/

/*:
/// Closure
*/

/*:
/// Methods
*/



/// 正则表达式
print("/// 正则表达式")

// 构造正则工具
struct RegexHelper {
    let regex: NSRegularExpression?
    init(_ pattern: String) {
        //var error: NSError?
        regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive)
    }
    func match(input: String) -> Bool {
        if let matches = regex?.matches(in: input, options: NSRegularExpression.MatchingOptions(rawValue:0), range: NSMakeRange(0, input.characters.count)) {
            //
            for match in matches {
                print((input as NSString).substring(with: match.range))
            }
            
            print("matches:\(matches[0].range.length)")
            return matches.count > 0
        } else {
            return false
        }
        
    }
}

// 验证
let mailPattern = "^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$"
let matcher = RegexHelper(mailPattern)
let maybeMailAddress = "123446@qq.com"

if matcher.match(input: maybeMailAddress)
{
    print("有效的邮箱地址")
}
else
{
    print("无效的邮箱地址")
    
}

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
let urlString = "https://www.baidu.com"
request(httpUrl: urlString)







