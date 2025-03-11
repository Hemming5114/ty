import UIKit
import SnapKit

class PrivacyPolicyViewController: UIViewController {
    private let scrollView = UIScrollView()
    private let stackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        title = "隐私政策"
        view.backgroundColor = .systemBackground
        
        // 设置滚动视图
        scrollView.backgroundColor = .systemBackground
        view.addSubview(scrollView)
        
        // 设置堆栈视图
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.alignment = .fill
        stackView.distribution = .fill
        scrollView.addSubview(stackView)
        
        // 布局约束
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
            make.width.equalTo(view).offset(-32)
        }
        
        // 添加内容
        addSection(
            title: "我们重视您的隐私",
            content: "桃遇致力于保护您的个人隐私。我们深知个人信息对您的重要性，我们将以高度的勤勉和审慎义务对待这些信息。",
            icon: "lock.shield.fill",
            color: .systemBlue
        )
        
        addSection(
            title: "我们收集的信息",
            content: """
            为了给您提供更好的服务，我们可能收集以下信息：
            • 个人信息：昵称、头像等基本信息
            • 使用数据：心情记录、对话内容、使用习惯等
            • 设备信息：设备型号、系统版本、使用时间等
            
            这些信息帮助我们：
            • 个性化您的使用体验
            • 提供更准确的情感分析
            • 改进我们的服务质量
            """,
            icon: "doc.text.fill",
            color: .systemIndigo
        )
        
        addSection(
            title: "信息的使用和保护",
            content: """
            您的信息安全对我们至关重要，我们采取多重措施保护您的隐私：
            
            • 数据加密：所有数据传输和存储都经过加密处理
            • 访问控制：严格的内部权限管理和访问控制
            • 安全存储：使用安全可靠的云服务器存储数据
            • 定期审计：定期进行安全审计和风险评估
            
            我们承诺：
            • 不会将您的个人信息出售给第三方
            • 不会在未经您授权的情况下分享您的信息
            • 采取一切合理措施保护您的隐私安全
            """,
            icon: "checkmark.shield.fill",
            color: .systemGreen
        )
        
        addSection(
            title: "您的权利",
            content: """
            作为用户，您拥有以下权利：
            
            • 访问权：随时查看您的个人信息
            • 更正权：更正不准确的个人信息
            • 删除权：删除您的账号和相关数据
            • 选择权：控制信息的收集和使用范围
            
            我们尊重您的选择，您可以：
            • 开启或关闭特定的数据收集功能
            • 导出或删除您的历史数据
            • 随时联系我们获取隐私相关帮助
            """,
            icon: "person.badge.shield.checkmark.fill",
            color: .systemOrange
        )
    }
    
    private func addSection(title: String, content: String, icon: String, color: UIColor) {
        let sectionView = UIView()
        sectionView.backgroundColor = .secondarySystemGroupedBackground
        sectionView.layer.cornerRadius = 12
        
        let iconView = UIImageView(image: UIImage(systemName: icon))
        iconView.tintColor = color
        iconView.contentMode = .scaleAspectFit
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = .systemFont(ofSize: 20, weight: .bold)
        titleLabel.textColor = color
        
        let contentLabel = UILabel()
        contentLabel.text = content
        contentLabel.font = .systemFont(ofSize: 15)
        contentLabel.textColor = .secondaryLabel
        contentLabel.numberOfLines = 0
        
        sectionView.addSubview(iconView)
        sectionView.addSubview(titleLabel)
        sectionView.addSubview(contentLabel)
        
        iconView.snp.makeConstraints { make in
            make.left.top.equalToSuperview().offset(16)
            make.size.equalTo(24)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(iconView.snp.right).offset(12)
            make.right.equalToSuperview().offset(-16)
            make.centerY.equalTo(iconView)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(iconView.snp.bottom).offset(12)
            make.left.right.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().offset(-16)
        }
        
        stackView.addArrangedSubview(sectionView)
    }
} 