class UserMenuCell: UITableViewCell {
    private let containerView = UIView()
    private let iconImageView = UIImageView()
    private let titleLabel = UILabel()
    private let arrowImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        selectionStyle = .none
        backgroundColor = .clear
        
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 12
        
        titleLabel.font = TYConstants.UI.Font.body
        titleLabel.textColor = .black
        
        arrowImageView.image = UIImage(systemName: "chevron.right")
        arrowImageView.tintColor = .systemGray3
        
        contentView.addSubview(containerView)
        containerView.addSubview(iconImageView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(arrowImageView)
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 12, bottom: 10, right: 12))
        }
        
        iconImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(24)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(iconImageView.snp.right).offset(12)
            make.centerY.equalToSuperview()
        }
        
        arrowImageView.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
            make.width.equalTo(16)
            make.height.equalTo(20)
        }
    }
    
    func configure(with item: MenuItem) {
        iconImageView.image = UIImage(systemName: item.icon)
        iconImageView.tintColor = item.color
        titleLabel.text = item.title
    }
} 
