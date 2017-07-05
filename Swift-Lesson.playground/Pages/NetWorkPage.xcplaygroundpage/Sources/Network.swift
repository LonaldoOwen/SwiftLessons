import Foundation


public class Network {
    
    public static func request(method: String, url: String, parameters: [String: Any], completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        
        let manager = NetworkManager(url: url, method: method, parameters: parameters, completionHandler: completionHandler)
        manager.run()
    }
}
