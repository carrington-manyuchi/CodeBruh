//
//  ViewController.swift
//  CodeBruh
//
//  Created by Manyuchi, Carrington C on 2025/01/10.
//

import UIKit

class HomeController: UIViewController {
    
    //MARK: - Variables
    private let viewModel: HomeControllerViewModel
    
    //MARK: - UI Components
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemBackground
        tableView.register(CoinCell.self, forCellReuseIdentifier:CoinCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    //MARK: - Lifecycle
    
    init(_ viewModel: HomeControllerViewModel = HomeControllerViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.viewModel.onCoinsUpdated = { [weak self]  in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
//        self.viewModel.onErrorMessage = { [weak self] error in
//            DispatchQueue.main.async {
//                let alert = UIAlertController(title: nil, message: "\(error)", preferredStyle: .alert)
//                alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
//                switch error {
//                case .serverError(_):
//                    alert.title = "Server Error"
//                   // alert.message = serverError.errorMessage
//                case .unknownError(_):
//                    alert.title = "Error fetching coins"
//                    alert.message = "Please try again later"
//                case .decodingError(_):
//                    alert.title = "Decoding Error"
//                    alert.message = "Error decoding JSON"
//                }
//                
//                self?.present(alert, animated: true, completion: nil)
//            }
//            
//        }
        
        self.view.backgroundColor = .blue
    }
    
    //MARK: - UI Setup
    private func setupUI() {
        self.navigationItem.title = "iCrypto"
        self.view.addSubview(tableView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        let tableViewConstraints = [
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(tableViewConstraints)
    }

}

//MARK: - Tableview Functions
extension HomeController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel.coins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CoinCell.identifier, for: indexPath) as? CoinCell else {
            fatalError("Unable to dequeue Coincell in HomeController")
        }
        let coin = self.viewModel.coins[indexPath.row]
        cell.configure(with: coin)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        let coin = self.viewModel.coins[indexPath.row]
        let vm = ViewCryptoControllerViewModel(coin: coin)
        let vc = ViewCryptoController(vm)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
