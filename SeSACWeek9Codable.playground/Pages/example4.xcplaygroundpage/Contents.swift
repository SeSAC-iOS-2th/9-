//: [Previous](@previous)

import Foundation

let json = """
{
"quote_content": "Count your age by friends, not years. Count your life by smiles, not tears.",
"author_name": "John Lennon"
}
"""

struct Quote: Decodable {
    let ment: String
    let author: String
    
    enum CodingKeys: String, CodingKey { //내부적으로 선언되어 있는 열거형
        case ment = "quote_content"
        case author = "name"
    }
}

//String -> Data
guard let result = json.data(using: .utf8) else { fatalError("Error") }

print(result)


//Data -> Quote
do {
    let value = try JSONDecoder().decode(Quote.self, from: result)
    print(value)
    print(value.ment)
    print(value.author)
    
} catch {
    print(error)
}

//: [Next](@next)
