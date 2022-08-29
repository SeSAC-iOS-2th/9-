//: [Previous](@previous)

import Foundation

struct User: Encodable {
    let name: String
    let signDate: Date
    let age: Int
}

let users: [User] = [
    User(name: "Joong", signDate: Date(), age: 23),
    User(name: "Elsa", signDate: Date(timeInterval: -86400, since: Date()), age: 18),
    User(name: "Emily", signDate: Date(timeIntervalSinceNow: 86400*2), age: 11)
]

print(users)

let encoder = JSONEncoder()
encoder.outputFormatting = .prettyPrinted
//encoder.dateEncodingStrategy = .iso8601 //iso

let format = DateFormatter()
format.locale = Locale(identifier: "ko-KR")
format.dateFormat = "MM월 dd일 EEEE"

encoder.dateEncodingStrategy = .formatted(format)

do {
    let result = try encoder.encode(users) //User > Data
    print(result)
    
    guard let jsonString = String(data: result, encoding: .utf8) else { //Data > String
        fatalError("ERROR")
    }
    
    print(jsonString)
    
} catch {
    print(error)
}

//: [Next](@next)
