/*:
 [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
 ****
 # Date
 */

import Foundation


/*:
 ## Date
 
 */

let now = Date.init()



/*:
 ## DataFormater
 
 */


/// ISO8601DateFormatter

let iso8601Formater = ISO8601DateFormatter()

// ISO8601DateFormatter.Options
let internetOption: ISO8601DateFormatter.Options = [.withFullDate, .withDashSeparatorInDate, .withTime, .withColonSeparatorInTime, .withColonSeparatorInTimeZone]
// Print"2018-01-16T03:03:36"
let internetDateTime: ISO8601DateFormatter.Options = [ISO8601DateFormatter.Options.withInternetDateTime]
// Print"2018-01-16T03:03:36"
iso8601Formater.formatOptions = internetOption

// 时区
iso8601Formater.timeZone = TimeZone.current

let str1 = iso8601Formater.string(from: now)
let date1 = iso8601Formater.date(from: str1)


/// DateFormatter

let formatter = DateFormatter()
formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
let str2 = formatter.string(from: now)
let date2 = formatter.date(from: str2)






//: [Next](@next)
