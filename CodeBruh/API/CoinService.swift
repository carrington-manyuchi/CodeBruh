//
//  CoinService.swift
//  CodeBruh
//
//  Created by Manyuchi, Carrington C on 2025/01/12.
//

import Foundation

enum CoinServiceError: Error {
    case serverError(CoinError)
    case unknown(String = "An unknown error occurred")
    case decodingError(String = "Error parsing server response")
}

class CoinService {
    static func fetchCoins(with endpoint: Endpoint, completion: @escaping (Result<[Coin], CoinServiceError>) -> Void) {
        guard let request = endpoint.request else { return }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                completion(.failure(.unknown(error.localizedDescription)))
            }
            
            if let response = response as? HTTPURLResponse, response.statusCode != 200 {
                do {
                    let decoder = JSONDecoder()
                    let errorData = try decoder.decode(CoinError.self, from: data ?? Data())
                    completion(.failure(.serverError(errorData)))
                } catch let error {
                    completion(.failure(.unknown()))
                    print(error.localizedDescription)
                }
            }
            
            if let data {
                do {
                    let decoder = JSONDecoder()
                    let coinData = try decoder.decode(CoinArray.self, from: data)
                    completion(.success(coinData.data))
                    print(coinData.data)
                } catch let error {
                    completion(.failure(.decodingError(error.localizedDescription)))
                    print(error.localizedDescription)
                }
            } else {
                completion(.failure(.unknown()))
            }
            
        }.resume()
    }
}

