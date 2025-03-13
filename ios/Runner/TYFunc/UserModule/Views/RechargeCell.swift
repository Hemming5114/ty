import UIKit
import SnapKit

class RechargeCell: UITableViewCell {
    private let containerView = UIView()
    private let coinsLabel = UILabel()
    private let priceLabel = UILabel()
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
        
        coinsLabel.font = .systemFont(ofSize: 18, weight: .medium)
        coinsLabel.textColor = .black
        
        priceLabel.font = .systemFont(ofSize: 20, weight: .bold)
        priceLabel.textColor = TYConstants.UI.themeColor
        
        buyButton.setTitle("购买", for: .normal)
        buyButton.setTitleColor(.white, for: .normal)
        buyButton.backgroundColor = TYConstants.UI.themeColor
        buyButton.layer.cornerRadius = 15
        buyButton.titleLabel?.font = .systemFont(ofSize: 14)
        
        contentView.addSubview(containerView)
        containerView.addSubview(coinsLabel)
        containerView.addSubview(priceLabel)
        containerView.addSubview(buyButton)
        
        setupConstraints()
        
        buyButton.addTarget(self, action: #selector(buyButtonTapped), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 4, left: 16, bottom: 4, right: 16))
            make.height.equalTo(80)
        }
        
        coinsLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(16)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.left.equalTo(coinsLabel)
            make.top.equalTo(coinsLabel.snp.bottom).offset(8)
        }
        
        buyButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
            make.width.equalTo(60)
            make.height.equalTo(30)
        }
    }
    
    func configure(with product: Product) {
        coinsLabel.text = "\(product.coins ?? 0)金币"
        priceLabel.text = "¥\(Int(product.price))"
    }
    
    @objc private func buyButtonTapped() {
        buyButtonTapHandler?()
    }
} 