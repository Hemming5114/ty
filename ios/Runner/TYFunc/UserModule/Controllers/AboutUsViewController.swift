import UIKit
import SnapKit

class AboutUsViewController: UIViewController {
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let logoImageView = UIImageView(image: UIImage(named: "about_icon"))
    private let versionLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let featuresStackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        title = "关于我们"
        view.backgroundColor = .systemBackground
        
        // 设置滚动视图
        scrollView.backgroundColor = .systemBackground
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        // Logo设置
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.layer.cornerRadius = 30
        logoImageView.clipsToBounds = true
        
        // 版本号
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            versionLabel.text = "版本 \(version)"
        }
        versionLabel.textAlignment = .center
        versionLabel.font = .systemFont(ofSize: 14)
        versionLabel.textColor = .systemGray
        
        // 应用描述
        descriptionLabel.text = "桃遇是一款融合AI技术的心情陪伴应用，致力于为用户提供温暖贴心的情感交流体验。"
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .center
        descriptionLabel.font = .systemFont(ofSize: 16)
        descriptionLabel.textColor = .secondaryLabel
        
        // 特性展示
        featuresStackView.axis = .vertical
        featuresStackView.spacing = 16
        featuresStackView.alignment = .fill
        featuresStackView.distribution = .fillEqually
        
        // 布局
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        contentView.addSubview(logoImageView)
        contentView.addSubview(versionLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(featuresStackView)
        
        logoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(40)
            make.centerX.equalToSuperview()
            make.height.equalTo(60)
        }
        
        versionLabel.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(versionLabel.snp.bottom).offset(24)
            make.left.right.equalToSuperview().inset(32)
        }
        
        featuresStackView.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(32)
            make.left.right.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().offset(-32)
        }
        
        // 添加特性卡片
        addFeature(
            icon: "heart.fill",
            color: .systemPink,
            title: "智能情感交流",
            description: "AI助手根据您的心情提供温暖贴心的对话"
        )
        
        addFeature(
            icon: "chart.bar.fill",
            color: .systemBlue,
            title: "心情管理",
            description: "记录和分析您的情绪变化，助您更好地了解自己"
        )
        
        addFeature(
            icon: "music.note",
            color: .systemPurple,
            title: "AI音乐",
            description: "享受AI生成的轻音乐，让心灵得到放松"
        )
        
        addFeature(
            icon: "sparkles",
            color: .systemOrange,
            title: "趣味探索",
            description: "发现生活中的美好，享受探索的乐趣"
        )
    }
    
    private func addFeature(icon: String, color: UIColor, title: String, description: String) {
        let cardView = UIView()
        cardView.backgroundColor = .secondarySystemGroupedBackground
        cardView.layer.cornerRadius = 12
        
        let iconView = UIImageView(image: UIImage(systemName: icon))
        iconView.tintColor = color
        iconView.contentMode = .scaleAspectFit
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = .systemFont(ofSize: 17, weight: .semibold)
        titleLabel.textColor = .label
        
        let descLabel = UILabel()
        descLabel.text = description
        descLabel.font = .systemFont(ofSize: 14)
        descLabel.textColor = .secondaryLabel
        descLabel.numberOfLines = 0
        
        cardView.addSubview(iconView)
        cardView.addSubview(titleLabel)
        cardView.addSubview(descLabel)
        
        iconView.snp.makeConstraints { make in
            make.left.top.equalToSuperview().offset(16)
            make.size.equalTo(24)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(iconView.snp.right).offset(12)
            make.right.equalToSuperview().offset(-16)
            make.centerY.equalTo(iconView)
        }
        
        descLabel.snp.makeConstraints { make in
            make.top.equalTo(iconView.snp.bottom).offset(8)
            make.left.right.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().offset(-16)
        }
        
        featuresStackView.addArrangedSubview(cardView)
    }
} 
