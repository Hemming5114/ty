import UIKit
import SnapKit

class DisclaimerViewController: UIViewController {
    private let scrollView = UIScrollView()
    private let stackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        title = "责任声明"
        view.backgroundColor = .systemBackground
        
        // 设置滚动视图和堆栈视图
        scrollView.backgroundColor = .systemBackground
        view.addSubview(scrollView)
        
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
            title: "服务说明",
            content: """
            桃遇是一款心情陪伴应用，我们希望通过AI技术为用户提供情感支持和陪伴。请注意：
            
            • 所有服务仅供个人使用和参考
            • AI生成的内容仅供娱乐，不构成专业建议
            • 背景音乐由AI生成，仅供个人使用和欣赏
            """,
            icon: "info.circle.fill",
            color: .systemBlue
        )
        
        addSection(
            title: "用户责任",
            content: """
            为了维护良好的使用环境，请您：
            
            • 遵守相关法律法规
            • 不传播违法违规内容
            • 保护好个人账号安全
            • 对自己的行为负责
            """,
            icon: "person.fill",
            color: .systemGreen
        )
        
        addSection(
            title: "免责声明",
            content: """
            请您理解，我们不对以下情况承担责任：
            
            • AI生成内容的准确性
            • 用户因使用服务造成的损失
            • 第三方的行为
            • 不可抗力因素导致的问题
            """,
            icon: "exclamationmark.shield.fill",
            color: .systemRed
        )
        
        addSection(
            title: "知识产权",
            content: """
            关于知识产权，请注意：
            
            • 应用内容的知识产权归我们所有
            • AI生成的音乐仅供个人使用
            • 未经授权不得用于商业目的
            """,
            icon: "doc.badge.gearshape.fill",
            color: .systemIndigo
        )
    }
    
    private func addSection(title: String, content: String, icon: String, color: UIColor) {
        // 使用与隐私政策相同的 section 样式
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