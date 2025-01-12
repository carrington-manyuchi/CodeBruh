//
//  ViewCryptoController.swift
//  CodeBruh
//
//  Created by Manyuchi, Carrington C on 2025/01/12.
//

import UIKit

class ViewCryptoController: UIViewController {
    
    //MARK: - Variables
    let viewModel: ViewCryptoControllerViewModel

    //MARK: - UI Components
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let coinLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "questionmark")
        imageView.tintColor = .label
        return imageView
    }()
    
    private let rankLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.text = "Error"
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.text = "Error"
        return label
    }()
    
    private let marketCapLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.text = "Error"
        return label
    }()
    
    private let maxSupplyLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var vStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [rankLabel, priceLabel, marketCapLabel, maxSupplyLabel])
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    
    //MARK: - Lifecycle
    init(_ viewModel: ViewCryptoControllerViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        self.navigationItem.title = self.viewModel.coin.name
        
        self.rankLabel.text = self.viewModel.rankLabel
        self.priceLabel.text = self.viewModel.priceLabel
        self.marketCapLabel.text = self.viewModel.marketCapLabel
        self.maxSupplyLabel.text = self.viewModel.maxSupplyLabel

        self.viewModel.onImageLoaded = { [weak self] logoImage in
            DispatchQueue.main.async {
                    self?.coinLogo.image = logoImage
            }
        }
    }
    
    //MARK: - UI Setup
    private func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(scrollView)
        self.scrollView.addSubview(contentView)
        contentView.addSubview(coinLogo)
        self.contentView.addSubview(vStack)
        
        self.setupConstraints()
    }
    
    private func setupConstraints() {
        
        let scrollViewConstraints = [
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        
        let contentViewConstraints = [
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ]
        
        let coinLogoConstraints = [
            coinLogo.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 50),
            coinLogo.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            coinLogo.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            coinLogo.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            coinLogo.heightAnchor.constraint(equalToConstant: 200),
        ]
        
        let vStackConstraints = [
            vStack.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            vStack.topAnchor.constraint(equalTo: coinLogo.bottomAnchor, constant: 20),
            vStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            vStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            vStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate( scrollViewConstraints + contentViewConstraints + coinLogoConstraints + vStackConstraints)
    }
}
