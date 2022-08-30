//
//  PersonAPIManager.swift
//  SeSACWeek9
//
//  Created by 이중원 on 2022/08/30.
//

import Foundation

class PersonAPIManager {
    
    static func requestPerson(query: String, completion: @escaping (Person?, APIError?) -> Void) {
        
        //let url = URL(string: "https://api.themoviedb.org/3/search/person?api_key=a3eec0c8e06d5d1896a3bd01c5f2e1a5&language=en-US&query=\(query)&page=1&include_adult=false&region=ko-KR")!
        
        let scheme = "https"
        let host = "api.themoviedb.org"
        let path = "/3/search/person"
        
        let language = "ko-KR"
        let key = "a3eec0c8e06d5d1896a3bd01c5f2e1a5"
        let query = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        var component = URLComponents()
        component.scheme = scheme
        component.host = host
        component.path = path
        component.queryItems = [
            URLQueryItem(name: "api_key", value: key),
            URLQueryItem(name: "query", value: query),
            URLQueryItem(name: "page", value: "1"),
            URLQueryItem(name: "region", value: language)
        ]
        
//        URLSession.request(endpoint: component.url) { success, fail in
//            <#code#>
//        }
        
        URLSession.shared.dataTask(with: component.url!) { data, response, error in
            
            
            DispatchQueue.main.async {
                guard error == nil else {
                    print("Failed Request")
                    completion(nil, .failedRequest)
                    return
                }
                
                guard let data = data else {
                    print("No Data Returned")
                    completion(nil, .noData)
                    return
                }
                
                guard let response = response as? HTTPURLResponse else {
                    print("Unable Response")
                    completion(nil, .invalidResponse)
                    return
                }
                
                guard response.statusCode == 200 else {
                    print("Failed Response")
                    completion(nil, .failedRequest)
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(Person.self, from: data)
                    completion(result, nil)
                } catch {
                    print(error)
                }
                
            }
                
            
        }.resume()
        
    }
        
}
