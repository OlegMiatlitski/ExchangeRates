import UIKit

final class TableViewCell: UITableViewCell {
    
    // MARK: - Properties
    // MARK: Public
    
    // MARK: Private
    
    private let backgroundLabel = UILabel()
    private let nameOfCriptoLabel = UILabel()
    private let valueOfCriptoLabel = UILabel()
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        setupConstraints()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - API
    
    func set(data: CoinClientModel) {
        nameOfCriptoLabel.text = data.name
        guard let price = data.priceUsd  else {
            return valueOfCriptoLabel.text = "$0.000"
        }
        valueOfCriptoLabel.text = "$\(NSString(format: "%.3f", price))"
        
    }
    
    // MARK: - Setups
    
    private func addSubviews() {
        contentView.addSubview(backgroundLabel)
        contentView.addSubview(nameOfCriptoLabel)
        contentView.addSubview(valueOfCriptoLabel)
    }
    
    private func setupConstraints() {
        
        backgroundLabel.translatesAutoresizingMaskIntoConstraints = false
        backgroundLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        backgroundLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        backgroundLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 7).isActive = true
        backgroundLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -7).isActive = true
        backgroundLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        nameOfCriptoLabel.translatesAutoresizingMaskIntoConstraints = false
        nameOfCriptoLabel.centerYAnchor.constraint(equalTo: backgroundLabel.centerYAnchor, constant: 0).isActive = true
        nameOfCriptoLabel.leadingAnchor.constraint(equalTo: backgroundLabel.leadingAnchor, constant: 15).isActive = true
        nameOfCriptoLabel.trailingAnchor.constraint(equalTo: backgroundLabel.centerXAnchor, constant: 0).isActive = true
        nameOfCriptoLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        valueOfCriptoLabel.translatesAutoresizingMaskIntoConstraints = false
        valueOfCriptoLabel.centerYAnchor.constraint(equalTo: backgroundLabel.centerYAnchor, constant: 0).isActive = true
        valueOfCriptoLabel.leadingAnchor.constraint(equalTo: backgroundLabel.centerXAnchor, constant: 0).isActive = true
        valueOfCriptoLabel.trailingAnchor.constraint(equalTo: backgroundLabel.trailingAnchor, constant: -15).isActive = true
        valueOfCriptoLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
    }
    
    private func setupUI() {
        contentView.backgroundColor = UIColor(red: 20/255, green: 18/255, blue: 29/255, alpha: 1.0)
        backgroundLabel.backgroundColor = UIColor(red: 37/255, green: 35/255, blue: 51/255, alpha: 1.0)
        backgroundLabel.layer.cornerRadius = 8
        backgroundLabel.layer.masksToBounds = true
        
        nameOfCriptoLabel.textColor = .white
        nameOfCriptoLabel.textAlignment = .left
        nameOfCriptoLabel.font = .systemFont(ofSize: 20, weight: .bold)
        
        valueOfCriptoLabel.textColor = .lightGray
        valueOfCriptoLabel.textAlignment = .right
        valueOfCriptoLabel.font = .systemFont(ofSize: 20, weight: .medium)
        
    }
}
