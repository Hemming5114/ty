import UIKit
import SnapKit

class MoodCollectionViewCell: UICollectionViewCell {
    private let emojiLabel = UILabel()
    private let nameLabel = UILabel()
    private var pulseAnimation: CABasicAnimation?
    private var rotationAnimation: CABasicAnimation?
    private var bounceAnimation: CAKeyframeAnimation?
    private var currentMood: Mood?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupAnimations()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.backgroundColor = .systemGray6
        contentView.layer.cornerRadius = TYConstants.UI.mainCornerRadius
        
        // 设置表情标签
        emojiLabel.font = .systemFont(ofSize: 40)
        emojiLabel.textAlignment = .center
        contentView.addSubview(emojiLabel)
        
        emojiLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(TYConstants.UI.Padding.normal)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(50)
        }
        
        // 设置名称标签
        nameLabel.font = TYConstants.UI.Font.subtitle
        nameLabel.textAlignment = .center
        contentView.addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(emojiLabel.snp.bottom).offset(TYConstants.UI.Padding.small)
            make.leading.trailing.equalToSuperview().inset(TYConstants.UI.Padding.small)
        }
    }
    
    private func setupAnimations() {
        // 1. 脉冲动画
        let pulse = CABasicAnimation(keyPath: "transform.scale")
        pulse.duration = 1.0
        pulse.fromValue = 1.0
        pulse.toValue = 1.1
        pulse.autoreverses = true
        pulse.repeatCount = .infinity
        pulseAnimation = pulse
        
        // 2. 旋转动画
        let rotation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.duration = 2.0
        rotation.fromValue = -0.1
        rotation.toValue = 0.1
        rotation.autoreverses = true
        rotation.repeatCount = .infinity
        rotationAnimation = rotation
        
        // 3. 弹跳动画
        let bounce = CAKeyframeAnimation(keyPath: "transform.translation.y")
        bounce.duration = 0.8
        bounce.values = [0, -8, 0]
        bounce.keyTimes = [0, 0.5, 1]
        bounce.timingFunctions = [
            CAMediaTimingFunction(name: .easeOut),
            CAMediaTimingFunction(name: .easeIn)
        ]
        bounce.repeatCount = .infinity
        bounceAnimation = bounce
    }
    
    func configure(with mood: Mood) {
        currentMood = mood
        emojiLabel.text = mood.emoji
        nameLabel.text = mood.name
        
        // 根据不同的心情设置不同的动画
        switch mood.id {
        case "happy", "excited":
            // 开心和兴奋的表情使用弹跳动画
            emojiLabel.layer.add(bounceAnimation!, forKey: "bouncing")
        case "calm":
            // 平静的表情使用缓慢的脉冲动画
            emojiLabel.layer.add(pulseAnimation!, forKey: "pulsing")
        case "tired":
            // 疲惫的表情使用缓慢的左右摇摆
            emojiLabel.layer.add(rotationAnimation!, forKey: "rotating")
        case "sad", "angry":
            // 难过和生气的表情使用抖动效果
            addShakeAnimation()
        default:
            break
        }
    }
    
    private func addShakeAnimation() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: .linear)
        animation.duration = 2.0
        animation.values = [-2, 2, -2, 2, -1, 1, 0]
        animation.repeatCount = .infinity
        emojiLabel.layer.add(animation, forKey: "shaking")
    }
    
    override var isSelected: Bool {
        didSet {
            contentView.backgroundColor = isSelected ? TYConstants.UI.themeColor.withAlphaComponent(0.3) : .systemGray6
            
            if isSelected {
                // 选中时添加放大动画
                let scaleAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
                scaleAnimation.values = [1.0, TYConstants.UI.Animation.Emoji.selectScale, 1.0]
                scaleAnimation.keyTimes = [0, 0.5, 1]
                scaleAnimation.duration = TYConstants.UI.Animation.Emoji.selectDuration
                emojiLabel.layer.add(scaleAnimation, forKey: "selected")
                
                // 移除之前的动画
                emojiLabel.layer.removeAnimation(forKey: "bouncing")
                emojiLabel.layer.removeAnimation(forKey: "pulsing")
                emojiLabel.layer.removeAnimation(forKey: "rotating")
                emojiLabel.layer.removeAnimation(forKey: "shaking")
            } else {
                // 取消选中时恢复原来的动画
                if let mood = currentMood {
                    configure(with: mood)
                }
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        emojiLabel.layer.removeAllAnimations()
        currentMood = nil
    }
} 