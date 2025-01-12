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
                DispatchQueue.main.async {
                    self?.onImageLoaded?(logoImage)
                }
            }
        }
    }
    
    //MARK: - Computed Properties
    
    var rankLabel: String {
        return "Rank: \(coin.rank)"
    }
    
    var priceLabel: String {
        return "Price: $\(coin.pricingData.CAD.price) CAD"
    }
    
    var marketCapLabel: String {
        return "Market Cap: $\(coin.pricingData.CAD.market_cap) CAD"
    }
    
    var maxSupplyLabel: String {
        
        if let maxSupply = self.coin.maxSupply{
            return "Max Supply: \(maxSupply)"
        } else {
            return "123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123\n123"
        }
    }
}
