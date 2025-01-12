//
//  HomeControllerViewModel.swift
//  CodeBruh
//
//  Created by Manyuchi, Carrington C on 2025/01/12.
//

import Foundation

class HomeControllerViewModel {
    
    var onCoinsUpdated: (() -> Void)?
    var onErrorMessage: ((CoinServiceError) -> Void)?
    
    private(set) var coins: [Coin] = [] {
        didSet {
            onCoinsUpdated?()
        }
    }
    
    init() {
        self.fetchCoins()
    }
    
    public func fetchCoins() {
        let endpoint = Endpoint.fetchCoins()
        
        CoinService.fetchCoins(with: endpoint) { [weak self] result in
            switch result {
            case .success(let coins):
                self?.coins = coins
            case .failure(let error):
                self?.onErrorMessage?(error)
            }
        }
    }
}
