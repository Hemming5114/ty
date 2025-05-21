
import UIKit

class BlockTableCell: UITableViewCell {
    private let containerView = UIView()
    private let avatarImageView = UIImageView()
    private let nameLabel = UILabel()
    private let descLabel = UILabel()
    private let tagsStack = UIStackView()
    private let personalityLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
        selectionStyle = .none
        
        // 设置容器视图
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 16
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 0.1
        containerView.layer.shadowOffset = CGSize(width: 0, height: 2)
        containerView.layer.shadowRadius = 8
        contentView.addSubview(containerView)
        
        // 设置头像
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.clipsToBounds = true
        avatarImageView.layer.cornerRadius = 12
        
        // 设置名称
        nameLabel.font = TYConstants.UI.Font.title
        nameLabel.textColor = .black
        
        // 设置描述
        descLabel.font = TYConstants.UI.Font.body
        descLabel.textColor = .darkGray
        descLabel.numberOfLines = 2
        
        // 设置性格标签
        personalityLabel.font = TYConstants.UI.Font.caption
        personalityLabel.textColor = TYConstants.UI.themeColor
        
        // 设置标签栈视图
        tagsStack.axis = .horizontal
        tagsStack.spacing = 8
        tagsStack.distribution = .fillEqually
        
        // 添加视图
        [avatarImageView, nameLabel, descLabel, personalityLabel, tagsStack].forEach {
            containerView.addSubview($0)
        }
        
        // 布局
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
        }
        
        avatarImageView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(16)
            make.width.equalTo(90)
            make.height.equalTo(90)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(avatarImageView)
            make.leading.equalTo(avatarImageView.snp.trailing).offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        personalityLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
            make.leading.equalTo(nameLabel)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        descLabel.snp.makeConstraints { make in
            make.top.equalTo(personalityLabel.snp.bottom).offset(8)
            make.leading.equalTo(nameLabel)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        tagsStack.snp.makeConstraints { make in
            make.top.equalTo(descLabel.snp.bottom).offset(12)
            make.leading.equalTo(nameLabel)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-16)
            make.height.equalTo(24)
        }
    }
    
    func configure(with model: AIModel) {
        avatarImageView.image = UIImage(named: model.avatarImageName)
        nameLabel.text = model.name
        descLabel.text = model.description
        personalityLabel.text = model.personality
        
        // 清除旧的标签
        tagsStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        // 添加新的标签
        model.tags.forEach { tag in
            let tagLabel = createTagLabel(text: tag)
            tagsStack.addArrangedSubview(tagLabel)
        }
        
        // 添加动画效果
        addHoverAnimation()
    }
    
    private func createTagLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = TYConstants.UI.Font.caption
        label.textColor = .white
        label.textAlignment = .center
        label.backgroundColor = TYConstants.UI.themeColor.withAlphaComponent(0.8)
        label.layer.cornerRadius = 12
        label.clipsToBounds = true
        return label
    }
    
    private func addHoverAnimation() {
        // 移除现有动画
        containerView.layer.removeAllAnimations()
        
        // 添加新的悬浮动画
        let hover = CAKeyframeAnimation(keyPath: "transform.translation.y")
        hover.values = [-2, 2]
        hover.duration = 2.0
        hover.autoreverses = true
        hover.repeatCount = .infinity
        hover.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        
        containerView.layer.add(hover, forKey: "hover")
    }
}


