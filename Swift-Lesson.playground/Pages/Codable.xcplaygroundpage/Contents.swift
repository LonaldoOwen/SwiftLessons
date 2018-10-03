//: [Previous](@previous)

import Foundation

var str = "Hello, playground"


/// Encoding and decoding JSON
func encodingAndDecodingJSON() {
    let json = """
[
{
"name": "Paul",
"age": 38
},
{
"name": "Andrew",
"age": 40
}
]
"""
    
    let data = Data(json.utf8)
    
    struct User: Codable {
        var name: String
        var age: Int
    }
    
    let decoder = JSONDecoder()
    do {
        let decoded = try decoder.decode([User].self, from: data)
        print(decoded[0].name)
    } catch  {
        print("Failed to decode JSON")
    }
}
print("=======  =======")
encodingAndDecodingJSON()



/// Converting case
/// Convert from "snake_case_keys" to "camelCaseKeys"
func convertingCase() {
    let json = """
[
    {
        "first_name": "Paul",
        "last_name": "Hudson"
    },
    {
        "first_name": "Andrew",
        "last_name": "Carnegie"
    }
]
"""
    let data = Data(json.utf8)
    
    struct User: Codable {
        var firstName: String
        var lastName: String
    }
    
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    do {
        let decoded = try decoder.decode([User].self, from: data)
        print(decoded[0].firstName)
    } catch let error {
        print(error)
        print("Failed to decode JSON")
    }
}
print("=======  =======")
convertingCase()



/// Mapping different key names
/// ???
func mappingDifferentKeyNames() {
    let json = """
[
    {
        "user_first_name": "Taylor",
        "user_last_name": "Swift",
        "user_age": 26
    }
]
"""
    let data = Data(json.utf8)
    
    struct User: Codable {
        var firstName: String
        var lastName: String
        var age: Int
        
        // Using custom coding keys
        ///
        enum CodingKeys: String, CodingKey {
            case firstName = "user_first_name"
            case lastName = "user_last_name"
            case age = "user_age"
        }
    }
    
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .useDefaultKeys
    do {
        let decoded = try decoder.decode([User].self, from: data)
        print(decoded[0].lastName)
    } catch let error {
        print(error)
        print("Failed to decode JSON")
    }
    
}
print("=======  =======")
mappingDifferentKeyNames()



/// Working with ISO-8601 dates
func workdingWithISO8601Dates() {
    let json = """
[
    {
        "first_name": "Theo",
        "time_of_birth": "1999-04-03T17:30:31Z"
    }
]
"""
    let data = Data(json.utf8)
    struct Baby: Codable {
        var firstName: String
        var timeOfBirth: Date
    }
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    decoder.dateDecodingStrategy = .iso8601
    do {
        let decoded = try decoder.decode([Baby].self, from: data)
        print(decoded[0].timeOfBirth)
    } catch  {
        print("Failed to decode JSON")
    }
}
print("======= workdingWithISO8601Dates =======")
workdingWithISO8601Dates()



/// Working with weird dates
///
func workingWithWeirdDates() {
    let json = """
[
    {
        "first_name": "Jess",
        "graduation_day": 10650
    }
]
"""
    let data = Data(json.utf8)
    
    struct Student: Codable {
        var firstName: String
        var graduationDay: Date
    }
    
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    decoder.dateDecodingStrategy = .custom({ decoder -> Date in
        // pull out the number of days from Codable
        let container = try decoder.singleValueContainer()
        let numberOfDays = try container.decode(Int.self)
        
        // create a start date of Jan 1st 1970, then a DateComponents instance for our JSON days
        let startDate = Date(timeIntervalSince1970: 0)
        var components = DateComponents()
        components.day = numberOfDays
        
        // create a Calendar and use it to measure the difference between the two
        let calendar = Calendar(identifier: .gregorian)
        return calendar.date(byAdding: components, to: startDate) ?? Date()
    })
    
    do {
        let decoded = try decoder.decode([Student].self, from: data)
        print(decoded[0].graduationDay)
    } catch  {
        print("Failed to decode JSON")
    }
}
print("======= workingWithWeirdDates =======")
workingWithWeirdDates()



/// Parsing hierarchical data the easy way
func parsingHierarchicalDataTheEasyWay() {
    let json = """
[
    {
        "name": {
            "first_name": "Taylor",
            "last_name": "Swift"
        },
        "age": 26
    }
]
"""
    let data = Data(json.utf8)
    
    struct User: Codable {
        struct Name: Codable {
            var firstName: String
            var lastName: String
        }
        
        var name: Name
        var age: Int
    }
    
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    do {
        let decoded = try decoder.decode([User].self, from: data)
        print(decoded[0].name.firstName)
    } catch  {
        print("Failed to decode JSON")
    }
}
print("======= parsingHierarchicalDataTheEasyWay =======")
parsingHierarchicalDataTheEasyWay()



/// Parsing hierarchical data the hard way
func parsingHierarchicalDataTheHardWay() {
    let json = """
[
    {
        "name": {
            "first_name": "Taylor",
            "last_name": "Swift"
        },
        "age": 26
    }
]
"""
    let data = Data(json.utf8)
    
    struct User: Codable {
        var firstName: String
        var lastName: String
        var age: Int
    
        enum CodingKeys: String, CodingKey {
            case name, age
        }
        enum NameCodingKeys: String, CodingKey {
            case firstName, lastName
        }
        
        /// Encode and Decode Manually
        // the Decodable methods
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            age = try container.decode(Int.self, forKey: .age)
            let name = try container.nestedContainer(keyedBy: NameCodingKeys.self, forKey: .name)
            firstName = try name.decode(String.self, forKey: .firstName)
            lastName = try name.decode(String.self, forKey: .lastName)
        }
        // the Encodable methods
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(age, forKey: .age)
            var name = container.nestedContainer(keyedBy: NameCodingKeys.self, forKey: .name)
            try name.encode(firstName, forKey: .firstName)
            try name.encode(lastName, forKey: .lastName)
        }
    }
    
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    do {
        let decoded = try decoder.decode([User].self, from: data)
        print(decoded[0].firstName)
    } catch  {
        print("Failed to decode JSON")
    }
}
print("======= parsingHierarchicalDataTheHardWay =======")
parsingHierarchicalDataTheHardWay()

//: [Next](@next)
