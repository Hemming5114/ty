import UIKit
import SnapKit

class SecretCell: UICollectionViewCell {
    private let containerView = UIView()
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    
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
        
        // 设置图片
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        
        // 设置标题
        titleLabel.font = .systemFont(ofSize: 18, weight: .medium)
        titleLabel.textColor = .black
        
        // 设置描述
        descriptionLabel.font = .systemFont(ofSize: 14)
        descriptionLabel.textColor = .gray
        descriptionLabel.numberOfLines = 2
        
        // 添加视图
        contentView.addSubview(containerView)
        containerView.addSubview(imageView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(descriptionLabel)
        
        // 布局
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
        }
        
        imageView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview().inset(16)
            make.height.equalTo(80)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(12)
            make.left.right.equalToSuperview().inset(16)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.left.right.equalTo(titleLabel)
            make.bottom.lessThanOrEqualToSuperview().offset(-16)
        }
    }
    
    func configure(with item: SecretItem) {
        imageView.image = UIImage(named: item.image)
        titleLabel.text = item.title
        descriptionLabel.text = item.description
    }
} 