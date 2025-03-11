class UserStatsView: UIView {
    private let iconImageView = UIImageView()
    private let titleLabel = UILabel()
    private let valueLabel = UILabel()
    
    init(icon: String, title: String) {
        super.init(frame: .zero)
        setupUI(icon: icon, title: title)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(icon: String, title: String) {
        backgroundColor = .systemGray6
        layer.cornerRadius = 12
        
        iconImageView.image = UIImage(systemName: icon)
        iconImageView.tintColor = TYConstants.UI.themeColor
        
        titleLabel.text = title
        titleLabel.font = TYConstants.UI.Font.subtitle
        titleLabel.textColor = .darkGray
        
        valueLabel.font = .systemFont(ofSize: 20, weight: .medium)
        valueLabel.textColor = TYConstants.UI.themeColor
        
        addSubview(iconImageView)
        addSubview(titleLabel)
        addSubview(valueLabel)
        
        iconImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(24)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(iconImageView.snp.right).offset(12)
            make.centerY.equalToSuperview()
        }
        
        valueLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
        }
    }
    
    func setValue(_ value: String) {
        valueLabel.text = value
    }
} 