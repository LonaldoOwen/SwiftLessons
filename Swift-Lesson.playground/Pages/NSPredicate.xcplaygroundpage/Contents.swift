/*:
 [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
 # NSPredicate
 
 */






import Foundation


class Person:NSObject {
    @objc var firstName: String
    @objc var lastName: String
    @objc var age: Int
    @objc var birthday: Date
    
    init(firstName: String, lastName: String, age: Int, birthday: Date) {
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
        self.birthday = birthday
    }
}

let zhangsan = Person(firstName: "san", lastName: "zhang", age: 20, birthday: Date.init())
let lisi = Person(firstName: "si", lastName: "li", age: 30, birthday: Date())
let wangwu = Person(firstName: "wu", lastName: "wang", age: 40, birthday: Date())
let persons = [zhangsan, lisi, wangwu]


/*:
 # NSPredicate
 
 
 */


/*:
 # Creating Predicates
 
 There are three ways to create a predicate in Cocoa: using a format string, directly in code, and from a predicate template.
 - using a format string
 - directly in code
 - from a predicate template
 */


/*:
 ## Creating a Predicate Using a Format String
 
 
 */

/// String Constants, Variables, and Wildcards
let prefix = "prefix"
let suffix = "suffix"
// SELF LIKE[c] "prefix*suffix"
let wildcardsPredicate = NSPredicate(format: "SELF LIKE[c] %@", prefix.appending("*").appending(suffix))
let wildcardsResult = wildcardsPredicate.evaluate(with: "prefixxxxxxxxxsuffix")
// 报错
//let errorWildcardsPredicate = NSPredicate(format: "SELF LIKE[c] %@*%@", prefix, suffix)
//let errorWildcardsResult = errorWildcardsPredicate.evaluate(with: "prefixxxxxxxxxsuffix")


/*:
 ## Creating Predicates Directly in Code
 You can create predicate and expression instances directly in code. NSComparisonPredicate and NSCompoundPredicate provide convenience methods that allow you to easily create compound and comparison predicates respectively. NSComparisonPredicate provides a number of operators ranging from simple equality tests to custom functions.
 
 */

// predicate: revenue > 1000000 AND revenue < 2000000
// predicate: age > 1000000 AND age < 2000000
let lhs = NSExpression(forKeyPath: "age")

let greaterRhs = NSExpression(forConstantValue: 1000000)
let greaterThanPredicate = NSComparisonPredicate(
    leftExpression: lhs,
    rightExpression: greaterRhs,
    modifier: .direct,
    type: .greaterThan,
    options: NSComparisonPredicate.Options.init(rawValue: 0))

let lessThanRhs = NSExpression(forConstantValue: 2000000)
let lessThanPredicate = NSComparisonPredicate(
    leftExpression: lhs,
    rightExpression: lessThanRhs,
    modifier: .direct,
    type: .lessThan,
    options: NSComparisonPredicate.Options.init(rawValue: 0))

let codePredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [greaterThanPredicate, lessThanPredicate])
let codeResult = codePredicate.evaluate(with: zhangsan)


/*:
 ## Creating Predicates Using Predicate Templates
 Predicate templates offer a good compromise between the easy-to-use but potentially error-prone format string-based technique and the code-intensive pure coding approach. A predicate template is simply a predicate that includes a variable expression. (If you are using the Core Data framework, you can use the Xcode design tools to add predicate templates for fetch requests to your model—see Managed Object Models.) The following example uses a format string to create a predicate with a right-hand side that is a variable expression.
 
 */




//class Person:NSObject {
//    @objc var firstName: String
//    @objc var lastName: String
//    @objc var age: Int
//    @objc var birthday: Date
//
//    init(firstName: String, lastName: String, age: Int, birthday: Date) {
//        self.firstName = firstName
//        self.lastName = lastName
//        self.age = age
//        self.birthday = birthday
//    }
//}
//
//let zhangsan = Person(firstName: "san", lastName: "zhang", age: 20, birthday: Date.init())
//let lisi = Person(firstName: "si", lastName: "li", age: 30, birthday: Date())
//let wangwu = Person(firstName: "wu", lastName: "wang", age: 40, birthday: Date())
//let persons = [zhangsan, lisi, wangwu]


let lastNameSearchString = "abcd"
let birthdaySearchDate = Date()
//let predicate = NSPredicate(format: "lastName like[cd] %@ AND birthday > %@", lastNameSearchString, birthdaySearchDate as CVarArg)







/*:
 ## Parser Basics
 
 
 */
/// 使用%K报错？？？
/// %K: key path，用来替换变量名;
/// %@: object value，用来替换变量值
/// $VARIABLE_NAME: 用来表示Variables
/// [c]: case-insensitive，大小写不敏感（即：A，a都可以）；修饰CONTAIN、LIKE等关键字
/// [d]: diacritic-insensitive，读音不敏感（）

/// %@
// lastName LIKE lastNameSearchString
let predicate = NSPredicate(format: "lastName like %@", lastNameSearchString)
// 报错：“error: Execution was interrupted, reason: signal SIGABRT.” ？？？
// 原因：NSPredicate应用需要满足object“class must be key-value coding compliant for the keys you want to use in a predicate.”
// 解决：Person继承NSObject，lastName增加@objc
let result = predicate.evaluate(with: zhangsan)

let zhangsanName = "zhangsan"
let zhangsanLastName = "zhang"
// zhangsan.lastName LIKE zhangsanLastName
let cPredicate = NSPredicate(format: "%@ like %@", zhangsan.lastName, zhangsanLastName)
let cResult = cPredicate.evaluate(with: zhangsan)

/// %K
// 定义propertyName用来存储属性名， value存储值
let propertyName = "lastName"
let value = "zhang"
let dPredicate = NSPredicate(format: "%K like %@", propertyName, value)
let dResult = dPredicate.evaluate(with: zhangsan)

/// $VARIABLE_NAME
// age > $AGE, 应用场景？？？
let dollarPredicateTemp = NSPredicate(format: "age > $AGE")
let dollarPredicate = dollarPredicateTemp.withSubstitutionVariables(["AGE": 5])
let dollarResult = dollarPredicate.evaluate(with: zhangsan)


/*:
 ## Basic Comparisons（比较运算符）
 
 =, ==
 - The left-hand expression is equal to the right-hand expression.
 
 ">=, =>"
 - The left-hand expression is greater than or equal to the right-hand expression.
 
 <=, =<
 - The left-hand expression is less than or equal to the right-hand expression.
 
 ">"
 - The left-hand expression is greater than the right-hand expression.
 
 <
 - The left-hand expression is less than the right-hand expression.

 !=, <>
 - The left-hand expression is not equal to the right-hand expression.
 
 
 */
/// =, == 用法
let equalPredicate = NSPredicate(format: "age = 10")
equalPredicate.evaluate(with: zhangsan)
let doubleEqualPredicate = NSPredicate(format: "age == 20")
doubleEqualPredicate.evaluate(with: zhangsan)

/// > 用法
// age > 10
let greaterPredicate = NSPredicate(format: "age > 10")
greaterPredicate.evaluate(with: zhangsan)


/*:
 ## Boolean Value Predicates
 TRUEPREDICATE
 A predicate that always evaluates to TRUE.
 FALSEPREDICATE
 A predicate that always evaluates to FALSE.

 
 */


/*:
 ## Basic Compound Predicates（复合断言）
 AND, &&
 - Logical AND.
 
 OR, ||
 - Logical OR.
 
 NOT, !
 - Logical NOT.

 */

// age > 5 AND age < 30
let andPredicate = NSPredicate(format: "age > 5 && age < 30")
let andResult = andPredicate.evaluate(with: zhangsan)

// lastName == "zhang" OR age > 5
let orPredicate = NSPredicate(format: "lastName = 'zhang' OR age > 5")
let orResult = orPredicate.evaluate(with: zhangsan)

//
let notPredicate = NSPredicate(format: "NOT firstName = 'sansan'")
let notResult = notPredicate.evaluate(with: zhangsan)


/*:
 ## String Comparisons (字符串比较)
 String comparisons are, by default, case and diacritic sensitive. You can modify an operator using the key characters c and d within square braces to specify case and diacritic insensitivity respectively, for example firstName BEGINSWITH[cd] $FIRST_NAME.
 
 BEGINSWITH
 - The left-hand expression begins with the right-hand expression.
 
 CONTAINS
 - The left-hand expression contains the right-hand expression.
 
 ENDSWITH
 - The left-hand expression ends with the right-hand expression.
 
 LIKE
 - The left hand expression equals the right-hand expression: ? and * are allowed as wildcard characters, where ? matches 1 character and * matches 0 or more characters.
 
 MATCHES
 - The left hand expression equals the right hand expression using a regex-style comparison according to ICU v3 (for more details see the ICU User Guide for Regular Expressions).
 
 UTI-CONFORMS-TO
 - ???
 
 UTI-EQUALS
 - ？？？
 
 */

// BEGINSWITH：
// lastName BEGINSWITH "zh"（表示：lastName是以 “zh” 开头的）
let beginwithPredicate = NSPredicate(format: "lastName BEGINSWITH 'zh'")
let beginwithResult = beginwithPredicate.evaluate(with: zhangsan)

// CONTAINS
// lastName CONTAINS "a"（表示：lastName 包含 "a"）
let containsPredicate = NSPredicate(format: "lastName CONTAINS 'a'")
let containsResult = containsPredicate.evaluate(with: zhangsan)

// ENDSWITH
// lastName ENDSWITH "ang"（表示：lastName 以 "ang" 结尾）
let endwithPredicate = NSPredicate(format: "lastName ENDSWITH 'ang'")
let endwithResult = endwithPredicate.evaluate(with: zhangsan)

// LIKE
// lastName LIKE "zhang"（lastName 和 "zhang" 相等）
let likePredicate = NSPredicate(format: "lastName LIKE 'zhang'")
let likeResult = likePredicate.evaluate(with: zhangsan)

// ?: matches 1 character（？可以代表一个任意字符）
let likePredicate2 = NSPredicate(format: "lastName LIKE '?hang'")
let likeResult2 = likePredicate2.evaluate(with: zhangsan)

// *: （* 可以代表0个或更多个字符）
let likePredicate3 = NSPredicate(format: "lastName LIKE 'z*g'")
let likeResult3 = likePredicate2.evaluate(with: zhangsan)

// MATCHES
// lastName MATCHES "[A-Za-z]+"（表示：lastName 匹配一个正则表达式 "[A-Za-z]+"）
let regex = "[A-Za-z]+"
let matchesPredicate = NSPredicate(format: "lastName MATCHES %@", regex)
let matchesResult = matchesPredicate.evaluate(with: zhangsan)

/// like[cd] is a modified “like” operator that is case-insensitive and diacritic-insensitive.
/// [c]: case-insensitive，大小写不敏感（即：A，a都可以）；修饰CONTAIN、LIKE等关键字
/// [d]: diacritic-insensitive，读音不敏感（）
let insensitiveString = "cafe"
let diacriticString = "café"
// SELF LIKE[c] "cafe"
let caseInsensitivePredicate = NSPredicate(format: "SELF LIKE[c] %@", insensitiveString)
let caseInsensitiveResult = caseInsensitivePredicate.evaluate(with: "Cafe")
// SELF LIKE[d] "café"
let diacriticInsensitivePredicate = NSPredicate(format: "SELF LIKE[d] %@", diacriticString)
let diacriticInsensitiveResult = diacriticInsensitivePredicate.evaluate(with: "cafe")


/*:
 ## Aggregate Operations（集合操作）
 
 ANY, SOME
 - Specifies any of the elements in the following expression. For example ANY children.age < 18.
 
 ALL
 - Specifies all of the elements in the following expression. For example ALL children.age < 18.
 
 NONE
 - Specifies none of the elements in the following expression. For example, NONE children.age < 18. This is logically equivalent to NOT (ANY ...).
 
 IN
 - Equivalent to an SQL IN operation, the left-hand side must appear in the collection specified by the right-hand side.
 - For example, name IN { 'Ben', 'Melissa', 'Nick' }. The collection may be an array, a set, or a dictionary—in the case of a dictionary, its values are used.
 - In Objective-C, you could create a IN predicate as shown in the following example:
 /*:
 - Example:
 NSPredicate *inPredicate = [NSPredicate predicateWithFormat: @"attribute IN %@", aCollection];
 */
 where aCollection may be an instance of NSArray, NSSet, NSDictionary, or of any of the corresponding mutable classes.
 
 */

// ANY, SOME
// ANY age < 40（表示：集合中，只要有 age < 40 的，结果就为true）
let anyPredicate = NSPredicate(format: "ANY age < 40")
let anyResult = anyPredicate.evaluate(with: persons)

// ALL
// ALL age < 40（表示：集合中，所有元素都有满足 age < 40 时，结果才为true）
let allPredicate = NSPredicate(format: "ALL age < 40")
let allResult = allPredicate.evaluate(with: persons)

// NONE
// NONE age < 10 == NOT ANY age < 10（表示，集合中，所有元素都不满足 age < 10 时，结果才为true）
let nonePredicate = NSPredicate(format: "NONE age < 10")
let noneResult = nonePredicate.evaluate(with: persons)

// IN
// lastName IN {"zhang", "li", "wang"}（表示：lastName在集合{"zhang", "li", "wang"}中）
let inPredicate = NSPredicate(format: "lastName IN %@", ["zhang", "li", "wang"])
let inResult = inPredicate.evaluate(with: zhangsan)



/*:
 ## Literals
 Single and double quotes produce the same result, but they do not terminate each other. For example, "abc" and 'abc' are identical, whereas "a'b'c" is equivalent to a space-separated concatenation of a, 'b', c.

 SELF
 - Represents the object being evaluated.

 */

/// SELF
// SELF IN {"Stig", "Shaffiq", "Chris"}
let selfPredicate = NSPredicate(format: "SELF IN %@", ["Stig", "Shaffiq", "Chris"])
let selfresult = selfPredicate.evaluate(with: "Shaffiq")



/*:
 ##
 
 
 */







//: [Next](@next)
