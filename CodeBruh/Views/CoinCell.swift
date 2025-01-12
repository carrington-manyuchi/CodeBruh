//
//  CoinCell.swift
//  CodeBruh
//
//  Created by Manyuchi, Carrington C on 2025/01/10.
//

import UIKit


class CoinCell: UITableViewCell {
    
    static let identifier: String = "CoinCell"
    
    //MARK: - Variables
    private(set) var coin: Coin!
    
    //MARK: - UI  Components
    private let coinLogo: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(systemName: "questionmark")
        iv.tintColor = .black
        return iv
    }()
    
    private let coinName: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Error"
        return label
    }()
    
    //MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with coin: Coin) {
        self.coin = coin
        self.coinName.text = coin.name
        
        DispatchQueue.global().async { [weak self] in
            if let logoURL = self?.coin.logoURL,
               let imageData = try? Data(contentsOf: logoURL),
               let logoImage = UIImage(data: imageData) {
                DispatchQueue.main.async {
                    self?.coinLogo.image = logoImage
                }
            }
        }
    }
    
    // TODO: - PrepareForReuse
    override func prepareForReuse() {
        super.prepareForReuse()
        self.coinLogo.image = nil
        self.coinName.text = nil
    }
    
    
    //MARK: - UI Setup
    private func setupUI() {
        self.addSubview(coinLogo)
        self.addSubview(coinName)
        setupConstraints()
    }
    
    private func setupConstraints() {
        let coinLogoConstraints = [
            coinLogo.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            coinLogo.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            coinLogo.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.75),
            coinLogo.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.75)
        ]
        
        let coinNameConstraints = [
            coinName.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            coinName.leadingAnchor.constraint(equalTo: coinLogo.trailingAnchor, constant: 16),
            coinName.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(coinLogoConstraints + coinNameConstraints)
    }
}
