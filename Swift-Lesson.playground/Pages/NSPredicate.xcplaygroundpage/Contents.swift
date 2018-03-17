/*:
 [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
 */
/*:
 # NSPredicate
 
 参考：\
 1、[Predicate Programming Guide](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/Predicates/AdditionalChapters/Introduction.html#//apple_ref/doc/uid/TP40001798-SW1)\
 2、
 
 创建时间：2018/03/16日
 
 */






import Foundation


class Person:NSObject {
    @objc var firstName: String
    @objc var lastName: String
    @objc var age: Int
    @objc var birthday: Date
    @objc var friends: [Person] = []
    @objc var bestFriend: Person? = nil
    
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
let zhaoliu = Person(firstName: "liu", lastName: "zhao", age: 25, birthday: Date())
let tianqi = Person(firstName: "qi", lastName: "tian", age: 31, birthday: Date())
let persons = [zhangsan, lisi, wangwu, zhaoliu, tianqi]
zhangsan.friends = [lisi, wangwu, tianqi]
zhangsan.bestFriend = tianqi


/*:
 # NSPredicate
 \
 \
 \
 ## Introduction
 Predicates provide a general means of specifying queries in Cocoa. The predicate system is capable of handling a large number of domains, including Core Data and Spotlight. This document describes predicates in general, their use, their syntax, and their limitations.
 \
 理解：\
 1、What NSPredicate do？\
 Predicates provide a general means of specifying queries in Cocoa.

 
 */


/*:
 ## Creating Predicates
 
 There are three ways to create a predicate in Cocoa: using a format string, directly in code, and from a predicate template.
 - using a format string
 - directly in code
 - from a predicate template
 */


/*:
 ## Creating a Predicate Using a Format String
 \
 You can use NSPredicate class methods of the form predicateWithFormat… to create a predicate directly from a string. You define the predicate as a string, optionally using variable substitution. At runtime, variable substitution—if any—is performed, and the resulting string is parsed to create corresponding predicate and expression objects. The following example creates a compound predicate with two comparison predicates.
 \
 
 */
///
let lastNameSearchString = "zhang"
let ageSearchNumber = NSNumber(value: 5)    // Note: 如果使用Int，会报错
// Predicate: lastName LIKE[c] "zhang" AND age > 5
let formatStringPredicate = NSPredicate(format: "lastName LIKE[c] %@ AND age > %@", lastNameSearchString, ageSearchNumber)


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
 You can create predicate and expression instances directly in code. `NSComparisonPredicate` and `NSCompoundPredicate` provide convenience methods that allow you to easily create compound and comparison predicates respectively. `NSComparisonPredicate` provides a number of operators ranging from simple equality tests to custom functions.
 
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
 \
 \
 理解：\
 1、A predicate template is simply a predicate that includes a variable expression. 
 
 */

// predicate template：lastName LIKE[c] $LAST_NAME
let predicateTemplate = NSPredicate(format: "lastName LIKE[c] $LAST_NAME")
// equal to
let templateLhs = NSExpression(forKeyPath: "lastName")
let templateRhs = NSExpression(forVariable: "$LAST_NAME")
let predicateTemplateEqual = NSComparisonPredicate(
    leftExpression: templateLhs,
    rightExpression: templateRhs,
    modifier: .direct,
    type: .like,
    options: .caseInsensitive)
// valid predicate：lastName LIKE[c] "zhang"
let validPredicate = predicateTemplate.withSubstitutionVariables(["LAST_NAME": "zhang"])
let templateResult = validPredicate.evaluate(with: zhangsan)




//let lastNameSearchString = "abcd"
//let birthdaySearchDate = Date()
//let predicate = NSPredicate(format: "lastName like[cd] %@ AND birthday > %@", lastNameSearchString, birthdaySearchDate as CVarArg)







/*:
 
 ## Predicate Format String Syntax
 
 This article describes the syntax of the predicate string and some aspects of the predicate parser.
 \
 The parser string is different from a string expression passed to the regex engine. This article describes the parser text, not the syntax for the regex engine.
 
 
 ### Parser Basics
 
 The predicate string parser is whitespace insensitive, case insensitive with respect to keywords, and supports nested parenthetical expressions. The parser does not perform semantic type checking.
 
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
 ### Basic Comparisons（比较运算符）
 
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
 
 BETWEEN
 - The left-hand expression is between, or equal to either of, the values specified in the right-hand side.
 - The right-hand side is a two value array (an array is required to specify order) giving upper and lower bounds. For example, `1 BETWEEN { 0 , 33 }`, or `$INPUT BETWEEN { $LOWER, $UPPER }`.
 
 
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

/// BETWEEN
// Predicate: age BETWEEN {5, 50}
let betweenPredicate = NSPredicate(format: "age BETWEEN %@", [5, 50])
let betweenResult = betweenPredicate.evaluate(with: zhangsan)


/*:
 ### Boolean Value Predicates
 
 TRUEPREDICATE\
 A predicate 'that' always evaluates to TRUE.\
 FALSEPREDICATE\
    A predicate that always evaluates to FALSE.

 
 */



/*:
 ### Basic Compound Predicates（复合断言）
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
 ### String Comparisons (字符串比较)
 String comparisons are, by default, case and diacritic sensitive. You can modify an operator using the key characters c and d within square braces to specify case and diacritic insensitivity respectively, for example `firstName BEGINSWITH[cd] $FIRST_NAME`.
 
 BEGINSWITH
 - The left-hand expression begins with the right-hand expression.
 
 CONTAINS
 - The left-hand expression contains the right-hand expression.
 
 ENDSWITH
 - The left-hand expression ends with the right-hand expression.
 
 LIKE
 - The left hand expression equals the right-hand expression: `?` and `*` are allowed as wildcard characters, where `?` matches `1` character and `*` matches `0 or more` characters.
 
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
 ### Aggregate Operations（集合操作）
 
 ANY, SOME
 - Specifies any of the elements in the following expression. For example `ANY children.age < 18`.
 
 ALL
 - Specifies all of the elements in the following expression. For example `ALL children.age < 18`.
 
 NONE
 - Specifies none of the elements in the following expression. For example, `NONE children.age < 18`. This is logically equivalent to `NOT (ANY ...)`.
 
 IN
 - Equivalent to an SQL IN operation, the left-hand side must appear in the collection specified by the right-hand side.
 - For example, `name IN { 'Ben', 'Melissa', 'Nick' }`. The collection may be an array, a set, or a dictionary—in the case of a dictionary, its values are used.
 - In Objective-C, you could create a IN predicate as shown in the following example:
 */
/*:
    NSPredicate *inPredicate = [NSPredicate predicateWithFormat: @"attribute IN %@", aCollection];
 */
/*:
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
 ### Literals
 Single and double quotes produce the same result, but they do not terminate each other. For example, "abc" and 'abc' are identical, whereas "a'b'c" is equivalent to a space-separated concatenation of a, 'b', c.

 SELF
 - Represents the object being evaluated.

 */

/// SELF
// SELF IN {"Stig", "Shaffiq", "Chris"}
let selfPredicate = NSPredicate(format: "SELF IN %@", ["Stig", "Shaffiq", "Chris"])
let selfresult = selfPredicate.evaluate(with: "Shaffiq")



/*:
 ## Using Predicates
 
 This document describes in general how you use predicates, and how the use of predicates may influence the structure of your application data.
 */
/*:
 ### Evaluating Predicates
 
 To evaluate a predicate, you use the NSPredicate method evaluateWithObject: and pass in the object against which the predicate will be evaluated. The method returns a Boolean value—in the following example, the result is YES.
 
 
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF IN %@", @[@"Stig", @"Shaffiq", @"Chris"]];
    BOOL result = [predicate evaluateWithObject:@"Shaffiq"];
 
 
 You can use predicates with any class of object, but the class must support **key-value coding** for the keys you want to use in a predicate.
 
 */
// Predicate: SELF IN {"Stig", "Shaffiq", "Chris"}（表示：数组中是否包含object（SELF））
let evaluatingPredicate = NSPredicate(format: "SELF IN %@", ["Stig", "Shaffiq", "Chris"])
let evaluatingResult: Bool = evaluatingPredicate.evaluate(with: "Shaffiq")




/*:
 ## Using Predicates with Arrays
 
 `NSArray` and `NSMutableArray` provide methods to filter array contents. `NSArray` provides `filteredArrayUsingPredicate:` which returns a new array containing objects in the receiver that match the specified predicate. `NSMutableArray` provides `filterUsingPredicate:` which evaluates the receiver’s content against the specified predicate and leaves only objects that match.
 \
 示例代码：
 
    NSMutableArray *names = [@[@"Nick", @"Ben", @"Adam", @"Melissa"] mutableCopy];
 
    NSPredicate *bPredicate = [NSPredicate predicateWithFormat:@"SELF beginswith[c] 'b'"];
    NSArray *beginWithB = [names filteredArrayUsingPredicate:bPredicate];
    // beginWithB contains { @"Ben" }.
 
    NSPredicate *ePredicate = [NSPredicate predicateWithFormat:@"SELF contains[c] 'e'"];
    [names filterUsingPredicate:ePredicate];
    // array now contains { @"Ben", @"Melissa" }
 
 If you use the Core Data framework, the array methods provide an efficient means of filtering an existing array of objects without—as a fetch does—requiring a round trip to a persistent data store.
 
 */

// Objective-C: Array are reference type
var names: NSMutableArray = ["Nick", "Ben", "Adam", "Melissa"]
let begainsWithBPredicate = NSPredicate(format: "SELF beginswith[c] 'b'")
let beginsWithBArray = names.filtered(using: begainsWithBPredicate) // names not changed
print("names:\(names)")

let containsEPredicate = NSPredicate(format: "SELF contains[c] 'e'")
names.filter(using: containsEPredicate) // names changed
print("names:\(names)")


// Swift: Array are value type
var swift_names = ["Nick", "Ben", "Adam", "Melissa"]

let swift_begainsWithBPredicate = NSPredicate(format: "SELF beginswith[c] 'b'")
let swift_beginsWithBArray = swift_names.filter { (item) -> Bool in
    swift_begainsWithBPredicate.evaluate(with: item)
}
print("swift_names: \(swift_names)")

let swift_containsEPredicate = NSPredicate(format: "SELF contains[c] 'e'")
swift_names.filter { (item) -> Bool in
    swift_containsEPredicate.evaluate(with: item)
}
print("swift_names: \(swift_names)")




/*:
 ## Using Predicates with Key-Paths
 
 Recall that you can follow relationships in a predicate using a **key path**. The following example illustrates the creation of a predicate to find employees that belong to a department with a given name (but see also **Performance**).
 
    NSString *departmentName = ... ;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"department.name like %@", departmentName];
 
 If you use a to-many relationship, the construction of a predicate is slightly different. If you want to fetch Departments in which at least one of the employees has the first name "Matthew," for instance, you use an `ANY` operator as shown in the following example:
 
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"ANY employees.firstName like 'Matthew'"];
 
 If you want to find Departments in which at least one of the employees is paid more than a certain amount, you use an `ANY` operator as shown in the following example:
 
    float salary = ... ;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"ANY employees.salary > %f", salary];

 */
let bestFriendLastName = "tian"
// Predicate: bestFriend.lastName LIKE "tian"
let bestFriendPredicate = NSPredicate(format: "bestFriend.lastName LIKE %@", bestFriendLastName)
let bestFriendResult = bestFriendPredicate.evaluate(with: zhangsan)

// Predicate: ANY friends.lastName LIKE "li"(朋友中至少有一个姓“li”)
// 注意：不加ANY会报错
let findFriendPredicate = NSPredicate(format: "ANY friends.lastName LIKE %@", "li")
let findFriendResult = findFriendPredicate.evaluate(with: zhangsan)

let age = 30
// Predicate: ANY friends.age > 20（朋友中至少有一个年龄大于30）
// 注意：使用>、=等运算符，不加ANY结果一样？？？
let findFriendByAgePredicate = NSPredicate(format: "friends.age > %d", age)
let findFriendByAgeResult = findFriendPredicate.evaluate(with: zhangsan)


/*:
 ## Using Null Values
 
 A comparison predicate does not match any value with null except null (nil) or the NSNull null value (that is, ($value == nil) returns YES if $value is nil). Consider the following example.
 
    NSString *firstName = @"Ben";
 
    NSArray *array = @[ @{ @"lastName" : "Turner" }];
                        @{ @"firstName" : @"Ben", @"lastName" : @"Ballard",
                            @"birthday", [NSDate dateWithString:@"1972-03-24 10:45:32 +0600"] } ];
 
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"firstName like %@", firstName];
    NSArray *filteredArray = [array filteredArrayUsingPredicate:predicate];
 
    NSLog(@"filteredArray: %@", filteredArray);
    // Output:
    // filteredArray ({birthday = 1972-03-24 10:45:32 +0600; \\
    firstName = Ben; lastName = Ballard;})
 
 The predicate does match the dictionary that contains a value `Ben` for the key `firstName`, but does not match the dictionary with no value for the key `firstName`. The following code fragment illustrates the same point using a date and a greater-than comparator.
 
    NSDate *referenceDate = [NSDate dateWithTimeIntervalSince1970:0];
 
    predicate = [NSPredicate predicateWithFormat:@"birthday > %@", referenceDate];
    filteredArray = [array filteredArrayUsingPredicate:predicate];
 
    NSLog(@"filteredArray: %@", filteredArray);
    // Output:
    // filteredArray: ({birthday = 1972-03-24 10:45:32 +0600; \\
    firstName = Ben; lastName = Ballard;})

 Testing for Null\
 If you want to match null values, you must include a specific test in addition to other comparisons, as illustrated in the following fragment.
 
    predicate = [NSPredicate predicateWithFormat:@"(firstName == %@) || (firstName = nil)", firstName];
    filteredArray = [array filteredArrayUsingPredicate:predicate];
    NSLog(@"filteredArray: %@", filteredArray);
 
    // Output:
    // filteredArray: ( { lastName = Turner; }, { birthday = 1972-03-23 20:45:32 -0800; firstName = Ben; lastName = Ballard; }
 
 By implication, a test for null that matches a null value returns true. In the following code fragment, `ok` is set to `YES` for both predicate evaluations.
 
    predicate = [NSPredicate predicateWithFormat:@"firstName = nil"];
    BOOL ok = [predicate evaluateWithObject:[NSDictionary dictionary]];
 
    ok = [predicate evaluateWithObject:
    [NSDictionary dictionaryWithObject:[NSNull null] forKey:@"firstName"]];

 
 */
/*:
 ##
 理解：\
 1、这块没理解透，还需再看看\
 2、这里面的代码示例存在错误\
 
 */

let nullPredicate = NSPredicate(format: "firstName = nil")
var ok: Bool = nullPredicate.evaluate(with: NSDictionary())
print(NSDictionary())
ok = nullPredicate.evaluate(with: NSDictionary(object: NSNull(), forKey: NSExpression(forKeyPath: "firstName")))
print(NSNull())
print(NSDictionary(object: NSNull(), forKey: NSExpression(forKeyPath: "firstName")))


/*:
 ## 主要Class和Methods
 
 
 
 ### Class
 
 `NSPredicate` \
    A specialized predicate that you use to compare expressions.
 
 NSComparisonPredicate, NSCompoundPredicate（subclass of NSPredicate）\
 - `NSComparisonPredicate` \
        A definition of logical conditions used to constrain a search either for a fetch or for in-memory filtering.\
 - `NSCompoundPredicate` \
        A specialized predicate that evaluates logical combinations of other predicates.
 
 `NSExpression` \
    An expression for use in a comparison predicate.
 
 */





/*:
 ## NSPredicate应用实例
 
 
 */


/*:
 ##
 
 
 */


/*:
 ##
 
 
 */







//: [Next](@next)
