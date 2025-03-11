class ExploreCell: UICollectionViewCell {
    private let containerView = UIView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let iconImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        // 设置容器视图
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 16
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 0.1
        containerView.layer.shadowOffset = CGSize(width: 0, height: 2)
        containerView.layer.shadowRadius = 8
        
        // 设置标题
        titleLabel.font = .systemFont(ofSize: 18, weight: .medium)
        titleLabel.textColor = TYConstants.UI.themeColor
        
        // 设置描述
        descriptionLabel.font = .systemFont(ofSize: 14)
        descriptionLabel.textColor = .gray
        descriptionLabel.numberOfLines = 2
        
        // 设置图标
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.tintColor = TYConstants.UI.themeColor
        
        // 添加视图
        contentView.addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(descriptionLabel)
        containerView.addSubview(iconImageView)
        
        // 布局
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(16)
            make.right.equalTo(iconImageView.snp.left).offset(-8)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.left.equalTo(titleLabel)
            make.right.equalTo(titleLabel)
            make.bottom.equalToSuperview().offset(-16)
        }
        
        iconImageView.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(24)
        }
    }
    
    func configure(with item: ExploreItem) {
        titleLabel.text = item.title
        descriptionLabel.text = item.description
        iconImageView.image = UIImage(systemName: "sparkles")
    }
} 