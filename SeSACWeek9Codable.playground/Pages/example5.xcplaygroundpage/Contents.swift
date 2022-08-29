//: [Previous](@previous)

import Foundation
//서버 응답 값을 변경해서 모델로 넣고 싶은 경우
//서버 3개 => 2개 // 3개 => 4개let
let json = """
{
"quote_content": "Count your age by friends, not years. Count your life by smiles, not tears.",
"author_name": null,
"likeCount": 12345
}
"""

struct Quote: Decodable {
    let ment: String
    let author: String
    let like: Int
    let isInfluencer: Bool //10000개 이상 좋아요 받은 경우
    
    
    enum CodingKeys: String, CodingKey { //내부적으로 선언되어 있는 열거형
        case ment = "quote_content"
        case author = "author_name"
        case like = "likeCount"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        ment = try container.decode(String.self, forKey: .ment)
        author = try container.decodeIfPresent(String.self, forKey: .author) ?? "unknown"
        like = try container.decode(Int.self, forKey: .like)
        isInfluencer = (10000...).contains(like) ? true : false
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
