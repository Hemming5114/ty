class MemberCell: UITableViewCell {
    private let containerView = UIView()
    private let titleLabel = UILabel()
    private let priceLabel = UILabel()
    private let durationLabel = UILabel()
    private let buyButton = UIButton()
    
    var buyButtonTapHandler: (() -> Void)?
    
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
        
        titleLabel.font = .systemFont(ofSize: 16, weight: .medium)
        titleLabel.textColor = .black
        
        priceLabel.font = .systemFont(ofSize: 20, weight: .bold)
        priceLabel.textColor = TYConstants.UI.themeColor
        
        durationLabel.font = .systemFont(ofSize: 14)
        durationLabel.textColor = .systemGray
        
        buyButton.setTitle("立即开通", for: .normal)
        buyButton.setTitleColor(.white, for: .normal)
        buyButton.backgroundColor = TYConstants.UI.themeColor
        buyButton.layer.cornerRadius = 15
        buyButton.titleLabel?.font = .systemFont(ofSize: 14)
        
        buyButton.addTarget(self, action: #selector(buyButtonTapped), for: .touchUpInside)
        
        contentView.addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(priceLabel)
        containerView.addSubview(durationLabel)
        containerView.addSubview(buyButton)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 4, left: 16, bottom: 4, right: 16))
            make.height.equalTo(80)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(16)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.left.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
        }
        
        durationLabel.snp.makeConstraints { make in
            make.left.equalTo(priceLabel.snp.right).offset(8)
            make.bottom.equalTo(priceLabel)
        }
        
        buyButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
            make.width.equalTo(80)
            make.height.equalTo(30)
        }
    }
    
    func configure(with product: Product) {
        titleLabel.text = product.name
        priceLabel.text = "¥\(Int(product.price))"
        if let duration = product.duration {
            durationLabel.text = "\(duration)天"
        }
    }
    
    @objc private func buyButtonTapped() {
        buyButtonTapHandler?()
    }
} 