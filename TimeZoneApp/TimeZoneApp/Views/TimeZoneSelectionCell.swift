import UIKit

class TimeZoneSelectionCell: UITableViewCell {
    
    private let nameLabel = UILabel()
    private let identifierLabel = UILabel()
    private let checkmarkImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        // Name label
        nameLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        nameLabel.textColor = .label
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(nameLabel)
        
        // Identifier label
        identifierLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        identifierLabel.textColor = .secondaryLabel
        identifierLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(identifierLabel)
        
        // Checkmark image view
        checkmarkImageView.image = UIImage(systemName: "checkmark")
        checkmarkImageView.tintColor = .systemBlue
        checkmarkImageView.contentMode = .scaleAspectFit
        checkmarkImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(checkmarkImageView)
        
        // Constraints
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            
            identifierLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            identifierLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            identifierLabel.trailingAnchor.constraint(lessThanOrEqualTo: checkmarkImageView.leadingAnchor, constant: -10),
            
            checkmarkImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            checkmarkImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            checkmarkImageView.widthAnchor.constraint(equalToConstant: 24),
            checkmarkImageView.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    func configure(with name: String, identifier: String, isSelected: Bool) {
        nameLabel.text = name
        identifierLabel.text = identifier
        checkmarkImageView.isHidden = !isSelected
    }
}
