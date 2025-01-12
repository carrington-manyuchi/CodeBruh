//
//  Endpoint.swift
//  CodeBruh
//
//  Created by Manyuchi, Carrington C on 2025/01/12.
//

import Foundation


enum Endpoint {
    case fetchCoins(url: String = "v1/cryptocurrency/lists/latest")
    //case postCoinsCoins(url: String = "v1/cryptocurrency/lists/latest")
    
    
    var request: URLRequest? {
        
        guard let url = self.url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = self.httpMethod
        request.httpBody = self.httpBody
        request.addValues(for: self)
        return request
    }
    
    private var url: URL? {
        var components = URLComponents()
        components.scheme = Constants.scheme
        components.host = Constants.baseURL
        components.port = Constants.port
        components.path = self.path
        components.queryItems = self.queryItems
        return components.url
    }
    
    private var path: String {
        switch self {
        case .fetchCoins(let url):
            // .postCoinsCoins(let url):
            return url
        }
    }
    
    private var queryItems: [URLQueryItem]? {
        switch self {
        case .fetchCoins:
            return [
                URLQueryItem(name: "limit", value: "150"),
                URLQueryItem(name: "sort", value: "market_cap"),
                URLQueryItem(name: "convert", value: "CAD"),
                URLQueryItem(name: "aux", value: "cmc_rank,max_supply,circulating_supply,total_supply")
            ]
        }
    }
    
    private var httpMethod: String {
        switch self {
        case .fetchCoins:
            return HTTP.Method.get.rawValue
//        case .postCoinsCoins:
//            return HTTP.Method.post.rawValue
        }
    }
    
    
    private var httpBody: Data? {
        switch self {
        case .fetchCoins:
            return nil
        }
    }
}


extension URLRequest {
    
    mutating func addValues(for endpoint: Endpoint) {
        switch endpoint {
        case .fetchCoins:
            self.setValue(HTTP.Header.Value.applicationJson.rawValue, forHTTPHeaderField: HTTP.Header.Key.contentType.rawValue)
            self.setValue(Constants.apiKey, forHTTPHeaderField: HTTP.Header.Key.apiKey.rawValue)
        }
    }
}
