import Foundation
import UIKit

// Nested Enumerations
enum HelpEnum {
    enum Color {
        case myColor(Int)
        case systemColor(Int)
        init?(number: Int) {
            switch number {
            case 1:
                self = .myColor(1)
            default:
                self = .systemColor(0)
            }
        }
    }
    enum Font {
        case mySize11, mySize12
    }
}
//extension Color {
//    
//}
