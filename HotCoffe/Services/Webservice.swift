//
//  Webservice.swift
//  HotCoffe
//
//  Created by Nayan joshi on 16/01/21.
//  Copyright © 2021 Nayan joshi. All rights reserved.
//

import Foundation
enum NetworkError :Error
{
    case decodingError
    case domainError
    case urlError
}
enum HttpMethod:String
{
    case get = "GET"
    case post = "POST"
}
struct Resource<T : Codable>
{
    let url : URL
    var httpMethod:HttpMethod = .get
    var body:Data? = nil
}
extension Resource
{
    init(url: URL){
        self.url = url
    }
}
class Webservice
{
    func load<T>(resource: Resource<T>,completion:@escaping (Result<T,NetworkError>)-> Void)
    {
        var request = URLRequest(url:resource.url)
        request.httpMethod = resource.httpMethod.rawValue
        request.httpBody = resource.body
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: resource.url)
        {
            data,response,error in
            guard let data = data , error == nil else
            {
                completion(.failure(.domainError))
                return
            }
            let result = try?JSONDecoder().decode(T.self, from: data)
            if let result = result
            {
                DispatchQueue.main.async {
                    completion(.success(result))
                }
            }
            else
            {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}
