import UIKit
import SnapKit

class ChatMessageCell: UITableViewCell {
    private let bubbleView = UIView()
    private let messageLabel = UILabel()
    private let timeLabel = UILabel()
    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 5
        return imageView
    }()
    
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
        
        bubbleView.layer.cornerRadius = 16
        
        messageLabel.numberOfLines = 0
        messageLabel.font = TYConstants.UI.Font.body
        
        timeLabel.font = TYConstants.UI.Font.caption
        timeLabel.textColor = .gray
        timeLabel.textAlignment = .center
        
        contentView.addSubview(timeLabel)
        contentView.addSubview(avatarImageView)
        contentView.addSubview(bubbleView)
        bubbleView.addSubview(messageLabel)
        
        timeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.centerX.equalToSuperview()
        }
        
        avatarImageView.snp.makeConstraints { make in
            make.width.height.equalTo(45)
        }
        
        bubbleView.snp.makeConstraints { make in
            make.top.equalTo(timeLabel.snp.bottom).offset(8)
            make.bottom.equalToSuperview().offset(-8)
            make.width.lessThanOrEqualTo(280)
        }
        
        messageLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(12)
        }
    }
    
    func configure(with message: ChatMessage, showTime: Bool = false, aiAvatar: String?) {
        timeLabel.text = showTime ? message.timestamp.chatTimeString() : nil
        timeLabel.isHidden = !showTime
        messageLabel.text = message.content
        
        let isUser = message.role == .user
        
        bubbleView.backgroundColor = isUser ? TYConstants.UI.themeColor : .white
        messageLabel.textColor = isUser ? .white : .black
        
        // 设置头像
        if isUser {
            if let user = User.loadFromKeychain(),
               let userAvatar = UIImage(named: user.avatar) {
                avatarImageView.image = userAvatar
            }
        } else if let aiAvatar = aiAvatar,
                  let aiImage = UIImage(named: aiAvatar) {
            avatarImageView.image = aiImage
        }
        
        // 重新设置约束
        avatarImageView.snp.remakeConstraints { make in
            make.width.height.equalTo(45)
            make.top.equalTo(timeLabel.snp.bottom).offset(showTime ? 8 : 0)
            if isUser {
                make.right.equalToSuperview().offset(-16)
            } else {
                make.left.equalToSuperview().offset(16)
            }
        }
        
        bubbleView.snp.remakeConstraints { make in
            make.top.equalTo(timeLabel.snp.bottom).offset(showTime ? 8 : 0)
            if isUser {
                make.right.equalTo(avatarImageView.snp.left).offset(-8)
            } else {
                make.left.equalTo(avatarImageView.snp.right).offset(8)
            }
            make.width.lessThanOrEqualTo(280)
            make.bottom.equalToSuperview().offset(-8)
        }
        
        messageLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(12)
        }
    }
} 
