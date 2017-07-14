//: [Previous](@previous)

import Foundation
import UIKit

/// UIColor
/* http://tool.oschina.net/commons?type=3 */
/*
 RGB:取值0.0~1.0（0.0：黑色，1.0：白色）
*/
let backView = UIView(frame: CGRect(x: 0, y: 0, width: 250, height: 150))
backView.backgroundColor = UIColor(red: 0/255.0, green: 245/255.0, blue: 255/255.0, alpha: 1.0) //Turquoise1	0 245 255	#00F5FF
//backView.backgroundColor = UIColor.white
let view1 = UIView(frame: CGRect(x: 10, y: 20, width: 100, height: 100))
let view2 = UIView(frame: CGRect(x: 120, y: 20, width: 100, height: 100))

var tempColor: UIColor
var RGBColor: UIColor
/* Black	0 0 0	#000000 */
tempColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)
RGBColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.4)
/* White	255 255 255	#FFFFFF */
//tempColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0)
//RGBColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
/* IndianRed	205 92 92	#CD5C5C */
//tempColor = UIColor(red: 205, green: 92, blue: 92, alpha: 1.0)
//RGBColor = UIColor(red: 205/255.0, green: 92/255.0, blue: 92/255.0, alpha: 1.0)
view1.backgroundColor = tempColor
view2.backgroundColor = RGBColor
backView.addSubview(view1)
backView.addSubview(view2)









//: [Next](@next)
