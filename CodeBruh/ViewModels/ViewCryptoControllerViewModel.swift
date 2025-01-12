//
//  ViewCryptoControllerViewModel.swift
//  CodeBruh
//
//  Created by Manyuchi, Carrington C on 2025/01/12.
//

import Foundation
import UIKit


class ViewCryptoControllerViewModel {
    
    var onImageLoaded: ((UIImage?) -> Void)?
    
    //MARK: - Variables
    let coin: Coin
    
    //MARK: - Initializer
    init(coin: Coin) {
        self.coin = coin
    }
    
    private func loadImage() {
        DispatchQueue.global().async { [weak self] in
            if let logoURL = self?.coin.logoURL,
               let imageData = try? Data(contentsOf: logoURL),
               let logoImage = UIImage(data: imageData) {
                self?.onImageLoaded?(logoImage)
            }
        }
    }
    
    //MARK: - Computed Properties
    
    var rankLabel: String {
        return "Rank: \(coin.cmc_rank)"
    }
    
    var priceLabel: String {
        return "Price: $\(coin.quote.CAD.price) CAD"
    }
    
    var marketCapLabel: String {
        return "Market Cap: $\(coin.quote.CAD.market_cap) CAD"
    }
    
    var maxSupplyLabel: String {
        
        if let maxSupply = self.coin.max_supply {
            return "Max Supply: \(maxSupply)"
        } else {
            return "123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123"
        }
    }
    

}
