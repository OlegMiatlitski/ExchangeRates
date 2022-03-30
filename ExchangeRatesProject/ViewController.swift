import UIKit

final class ViewController: UIViewController {
    
    // MARK: Private
    
    private var criptoSearchController =  UISearchController()
    private let tableView = UITableView()
    private var arrayOfCripto: [CoinClientModel] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    private var activityIndicator = UIActivityIndicatorView(style: .large)
    private let reuseidentifier = "TableViewCell"
    private var searchArray: [CoinClientModel] = []
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupTableView()
        addConstraints()
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showActivityIndicator()
        APIManager.instance.getAllExchanges() { result in
            switch result {
            case .success(let data):
                self.arrayOfCripto = data
                self.hideActivityIndicator()
            case .failure(_):
                let alert = UIAlertController(
                    title: "Error!!!",
                    message: "Couldn't find any info about Exchange Rates",
                    preferredStyle: .alert
                )
                alert.addAction(UIAlertAction(title: "OK", style: .cancel))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    // MARK: - Setups
    
    private func showActivityIndicator(){
        view.isUserInteractionEnabled = false
        let viewController = tabBarController ?? navigationController ?? self
        activityIndicator.frame = CGRect(
            x: 0,
            y: 0,
            width: viewController.view.frame.width,
            height: viewController.view.frame.height
        )
        viewController.view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    private func hideActivityIndicator(){
        view.isUserInteractionEnabled = true
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
    }
    
    private func addSubviews() {
        view.addSubview(tableView)
    }
   
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        criptoSearchController = UISearchController(searchResultsController: nil)
        criptoSearchController.searchResultsUpdater = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        self.tableView.register(TableViewCell.self, forCellReuseIdentifier: reuseidentifier)
    }
    
    private func addConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 150).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5).isActive = true
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(red: 20/255, green: 18/255, blue: 29/255, alpha: 1.0)
        tableView.backgroundColor = UIColor(red: 20/255, green: 18/255, blue: 29/255, alpha: 1.0)
        criptoSearchController.searchBar.placeholder = "Search"
        navigationItem.searchController = criptoSearchController
        criptoSearchController.searchBar.searchTextField.layer.masksToBounds = true
        criptoSearchController.searchBar.searchTextField.layer.cornerRadius = 5
        criptoSearchController.searchBar.barTintColor = UIColor(red: 20/255, green: 18/255, blue: 29/255, alpha: 1.0)
        criptoSearchController.searchBar.backgroundColor = .clear
        title = "Exchange Rates"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.titleTextAttributes =  [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 35),
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating, UISearchBarDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if criptoSearchController.isActive {
            return searchArray.count
        } else {
            return arrayOfCripto.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.register(TableViewCell.self, forCellReuseIdentifier: reuseidentifier)
        if let cell = tableView.dequeueReusableCell(
            withIdentifier: reuseidentifier, for: indexPath
        ) as? TableViewCell {
            let cripto = (criptoSearchController.isActive) ? searchArray[indexPath.row] : arrayOfCripto[indexPath.row]
            cell.set(cripto.name ?? "", cripto.priceUsd)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.alpha = 0
        UIView.animate(
            withDuration: 0.1,
            delay: 0.05 * Double(indexPath.row),
            animations: {
                cell.alpha = 1
            }
        )
    }
    func filterData(for SearchText: String) {
        searchArray = arrayOfCripto.filter { array -> Bool in
            if let name = array.name?.lowercased() {
                return name.hasPrefix(SearchText.lowercased())
            }
            return false
        }
    }
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            filterData(for: searchText)
            tableView.reloadData()
        }
    }
}
