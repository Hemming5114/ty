import UIKit
import SnapKit

class ChatSessionCell: UITableViewCell {
    private let containerView = UIView()
    private let avatarImageView = UIImageView()
    private let nameLabel = UILabel()
    private let messageLabel = UILabel()
    private let timeLabel = UILabel()
    
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
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 0.1
        containerView.layer.shadowOffset = CGSize(width: 0, height: 2)
        containerView.layer.shadowRadius = 4
        
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.layer.cornerRadius = 22
        avatarImageView.layer.masksToBounds = true
        
        nameLabel.font = TYConstants.UI.Font.title
        nameLabel.textColor = .black
        
        messageLabel.font = TYConstants.UI.Font.body
        messageLabel.textColor = .darkGray
        messageLabel.numberOfLines = 1
        
        timeLabel.font = TYConstants.UI.Font.caption
        timeLabel.textColor = .gray
        timeLabel.textAlignment = .right
        
        // 添加视图
        contentView.addSubview(containerView)
        [avatarImageView, nameLabel, messageLabel, timeLabel].forEach {
            containerView.addSubview($0)
        }
        
        // 布局
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16))
        }
        
        avatarImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(12)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(44)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(avatarImageView)
            make.leading.equalTo(avatarImageView.snp.trailing).offset(12)
            make.trailing.equalTo(timeLabel.snp.leading).offset(-8)
        }
        
        messageLabel.snp.makeConstraints { make in
            make.leading.equalTo(nameLabel)
            make.bottom.equalTo(avatarImageView)
            make.trailing.equalTo(timeLabel.snp.leading).offset(-8)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel)
            make.trailing.equalToSuperview().offset(-12)
            make.width.equalTo(80)
        }
    }
    
    func configure(with session: ChatSession) {
        avatarImageView.image = UIImage(named: session.aiModel.avatarImageName)
        nameLabel.text = session.aiModel.name
        messageLabel.text = session.messages.last?.content ?? "暂无消息"
        timeLabel.text = session.lastMessageAt.chatTimeString()
    }
} 
