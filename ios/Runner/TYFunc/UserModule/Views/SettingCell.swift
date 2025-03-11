import UIKit
import SnapKit

class SettingCell: UITableViewCell {
    private let iconImageView = UIImageView()
    private let titleLabel = UILabel()
    private let toggleSwitch = UISwitch()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.tintColor = .systemGray
        
        titleLabel.font = TYConstants.UI.Font.body
        
        contentView.addSubview(iconImageView)
        contentView.addSubview(titleLabel)
        
        iconImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(22)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(iconImageView.snp.right).offset(12)
            make.centerY.equalToSuperview()
        }
    }
    
    func configure(with item: SettingItem) {
        iconImageView.image = UIImage(systemName: item.icon)
        titleLabel.text = item.title
        
        switch item.type {
        case .toggle:
            accessoryView = toggleSwitch
        case .arrow:
            accessoryType = .disclosureIndicator
        case .none:
            accessoryType = .none
        }
        
        // 设置退出登录的样式
        if item.title == "退出登录" {
            titleLabel.textColor = .systemRed
            iconImageView.tintColor = .systemRed
        } else {
            titleLabel.textColor = .black
            iconImageView.tintColor = .systemGray
        }
    }
} 