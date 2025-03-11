import UIKit
import SnapKit

class EmptyStateView: UIView {
    private let imageView = UIImageView()
    private let messageLabel = UILabel()
    
    init(message: String, image: UIImage? = UIImage(systemName: "bubble.left.and.bubble.right")) {
        super.init(frame: .zero)
        setupUI(message: message, image: image)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(message: String, image: UIImage?) {
        // 设置图片
        imageView.image = image
        imageView.tintColor = TYConstants.UI.themeColor.withAlphaComponent(0.5)
        imageView.contentMode = .scaleAspectFit
        
        // 设置文本
        messageLabel.text = message
        messageLabel.font = TYConstants.UI.Font.subtitle
        messageLabel.textColor = .gray
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 0
        
        // 添加视图
        addSubview(imageView)
        addSubview(messageLabel)
        
        // 布局
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
            make.width.height.equalTo(80)
        }
        
        messageLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(16)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
} 