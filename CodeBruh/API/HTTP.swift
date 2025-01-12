//
//  HTTP.swift
//  CodeBruh
//
//  Created by Manyuchi, Carrington C on 2025/01/12.
//

import Foundation

enum HTTP {
    static func request(url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        return request
    }
    
    enum Method: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case delete = "DELETE"
    }
    
    enum Header  {
        enum Key: String {
            case contentType = "Content-Type"
            case apiKey = "X-CMC_PRO_API_KEY"
        }
        
        enum Value: String {
            case applicationJson = "application/json"
        }
    }
}
