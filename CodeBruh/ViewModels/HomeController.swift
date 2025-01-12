//
//  ViewController.swift
//  CodeBruh
//
//  Created by Manyuchi, Carrington C on 2025/01/10.
//

import UIKit

class HomeController: UIViewController {
    
    //MARK: - Variables
    private let coins: [Coin] = Coin.getMockArray()
    
    //MARK: - UI Components
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemBackground
        tableView.register(CoinCell.self, forCellReuseIdentifier:CoinCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
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
        self.coins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CoinCell.identifier, for: indexPath) as? CoinCell else {
            fatalError("Unable to dequeue Coincell in HomeController")
        }
        let coin = self.coins[indexPath.row]
        cell.configure(with: coin)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        let coin = self.coins[indexPath.row]
        let vc = ViewCryptoController(coin: coin)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
