import UIKit
import Alamofire

final class ViewController: UIViewController {
    
    // MARK: - Properties
    // MARK: Public
    // MARK: Private
    
    private let exchangeRatesLabel = UILabel()
    private let tableView = UITableView()
    private var arrayOfCripto: [CoinClientModel] = [] {
        didSet {
            tableView.reloadData()
        }
    }

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
        APIManager.instance.getAllExchanges() { data in
            self.arrayOfCripto = data
        }
    }
    
    // MARK: - Setups
    
    private func addSubviews() {
        view.addSubview(exchangeRatesLabel)
        view.addSubview(tableView)
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "TableViewCell")
    }
    
    private func addConstraints() {
        
        exchangeRatesLabel.translatesAutoresizingMaskIntoConstraints = false
        exchangeRatesLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        exchangeRatesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        exchangeRatesLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        exchangeRatesLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: exchangeRatesLabel.bottomAnchor, constant: 15).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5).isActive = true
    }
    
    private func setupUI() {
        
        view.backgroundColor = UIColor(red: 20/255, green: 18/255, blue: 29/255, alpha: 1.0)
        tableView.backgroundColor = UIColor(red: 20/255, green: 18/255, blue: 29/255, alpha: 1.0)
        exchangeRatesLabel.textColor = .white
        exchangeRatesLabel.textAlignment = .left
        exchangeRatesLabel.font = .systemFont(ofSize: 35, weight: .bold)
        exchangeRatesLabel.text = "Exchange Rates"
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfCripto.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        if let cell = tableView.dequeueReusableCell(
            withIdentifier: "TableViewCell", for: indexPath
        ) as? TableViewCell {
            cell.set(data: arrayOfCripto[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
}
