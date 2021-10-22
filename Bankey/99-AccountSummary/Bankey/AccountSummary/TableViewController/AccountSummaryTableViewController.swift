//
//  AccountSummaryViewController.swift
//  Bankey
//
//  Created by jrasmusson on 2021-10-11.
//

import UIKit

class AccountSummaryTableViewController: UIViewController {
    
    struct Profile {
        let firstName: String
        let lastName: String
    }

    var profile: Profile?
    var accounts: [AccountSummaryCell.ViewModel] = []

    var headerView = AccountSummaryHeaderView(frame: .zero)
    var tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

// MARK: - Setup
extension AccountSummaryTableViewController {
    private func setup() {
        setupTableView()
        setupTableHeaderView()
        fetchData()
    }
    
    private func setupTableView() {
        tableView.backgroundColor = .systemTeal
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(AccountSummaryCell.self, forCellReuseIdentifier: AccountSummaryCell.reuseID)
        tableView.rowHeight = AccountSummaryCell.rowHeight
        tableView.tableFooterView = UIView()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupTableHeaderView() {
        var size = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        size.width = UIScreen.main.bounds.width
        headerView.frame.size = size
        
        tableView.tableHeaderView = headerView
    }
}

// MARK: - UITableViewDataSource
extension AccountSummaryTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard !accounts.isEmpty else { return UITableViewCell() }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: AccountSummaryCell.reuseID, for: indexPath) as! AccountSummaryCell
        let account = accounts[indexPath.row]
        cell.configure(with: account)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accounts.count
    }
}

// MARK: - UITableViewDelegate
extension AccountSummaryTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

// MARK: - Networking
extension AccountSummaryTableViewController {
    private func fetchData() {
        fetchAccounts()
        fetchProfile()
    }
    
    private func fetchAccounts() {
        let savings = AccountSummaryCell.ViewModel(accountType: .Banking,
                                                    accountName: "Basic Savings",
                                                    balanceAmount: 929466.23)
        let chequing = AccountSummaryCell.ViewModel(accountType: .Banking,
                                                    accountName: "No-Fee All-In Chequing",
                                                    balanceAmount: 17562.44)
        let visa = AccountSummaryCell.ViewModel(accountType: .CreditCard,
                                                       accountName: "Visa Avion Card",
                                                       balanceAmount: 412.83)
        let masterCard = AccountSummaryCell.ViewModel(accountType: .CreditCard,
                                                       accountName: "Student Mastercard",
                                                       balanceAmount: 50.83)
        let investment1 = AccountSummaryCell.ViewModel(accountType: .Investment,
                                                       accountName: "Tax-Free Saver",
                                                       balanceAmount: 2000.00)
        let investment2 = AccountSummaryCell.ViewModel(accountType: .Investment,
                                                       accountName: "Growth Fund",
                                                       balanceAmount: 15000.00)

        accounts.append(savings)
        accounts.append(chequing)
        accounts.append(visa)
        accounts.append(masterCard)
        accounts.append(investment1)
        accounts.append(investment2)
    }
    
    private func fetchProfile() {
        profile = Profile(firstName: "Kevin", lastName: "Smith")
        configureTableHeaderView(with: profile!)
    }
    
    private func configureTableHeaderView(with profile: Profile) {
        let vm = AccountSummaryHeaderView.ViewModel(welcomeMessage: "Good morning,", name: profile.firstName, date: Date())
        headerView.configure(viewModel: vm)
    }
}
