import UIKit
import SnapKit

class UserViewController: UIViewController {
    // MARK: - UI Components
    private let headerView = UIView()
    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 40
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = TYConstants.UI.themeColor.cgColor
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.textColor = .black
        return label
    }()
    
    private let idLabel: UILabel = {
        let label = UILabel()
        label.font = TYConstants.UI.Font.caption
        label.textColor = .gray
        return label
    }()
    
    private let coinsView = UserStatsView(icon: "dollarsign.circle.fill", title: "桃币")
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    // MARK: - Properties
    private let sections: [[MenuItem]] = [
        // 通用
        [
            MenuItem(icon: "trash.fill", title: "清除缓存", color: .systemRed),
            MenuItem(icon: "bell.badge.fill", title: "消息通知", color: .systemOrange)
        ],
        // 支持与帮助
        [
            MenuItem(icon: "questionmark.circle.fill", title: "帮助中心", color: .systemBlue),
            MenuItem(icon: "exclamationmark.bubble.fill", title: "意见反馈", color: .systemGreen)
        ],
        // 关于
        [
            MenuItem(icon: "hand.raised.fill", title: "隐私政策", color: .systemIndigo),
            MenuItem(icon: "doc.text.fill", title: "责任声明", color: .systemGray),
            MenuItem(icon: "info.circle.fill", title: "关于我们", color: .systemBlue)
        ]
    ]
    
    private let sectionTitles = ["通用", "支持与帮助", "关于"]
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadUserInfo()
        setupGestures()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        view.backgroundColor = .systemGroupedBackground
        navigationItem.title = "我的"
        
        // 添加头部视图
        headerView.backgroundColor = .white
        headerView.layer.cornerRadius = 12
        view.addSubview(headerView)
        headerView.addSubview(avatarImageView)
        headerView.addSubview(nameLabel)
        headerView.addSubview(idLabel)
        
        // 添加刷新名称按钮
        let refreshButton = UIButton()
        refreshButton.setImage(UIImage(systemName: "arrow.clockwise.circle.fill"), for: .normal)
        refreshButton.tintColor = TYConstants.UI.themeColor
        refreshButton.addTarget(self, action: #selector(refreshNameTapped), for: .touchUpInside)
        
        headerView.addSubview(refreshButton)
        refreshButton.snp.makeConstraints { make in
            make.left.equalTo(nameLabel.snp.right).offset(8)
            make.centerY.equalTo(nameLabel)
            make.width.height.equalTo(24)
        }
        
        // 添加表格视图
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UserMenuCell.self, forCellReuseIdentifier: "MenuCell")
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.contentInsetAdjustmentBehavior = .never
        view.addSubview(tableView)
        
        // 设置约束
        setupConstraints()
    }
    
    private func setupConstraints() {
        headerView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(12)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(120)
        }
        
        avatarImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(80)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.left.equalTo(avatarImageView.snp.right).offset(16)
            make.top.equalTo(avatarImageView).offset(12)
        }
        
        idLabel.snp.makeConstraints { make in
            make.left.equalTo(nameLabel)
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset(12)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-80)
        }
    }
    
    private func loadUserInfo() {
        if let user = User.loadFromKeychain() {
            nameLabel.text = user.name
            idLabel.text = "ID: \(user.id)"
            // 设置头像
            if let avatarImage = UIImage(named: user.avatar) {
                avatarImageView.image = avatarImage
            }
            coinsView.setValue("\(user.coins)")
        }
    }
    
    private func setupGestures() {
        // 头像点击手势
        let avatarTap = UITapGestureRecognizer(target: self, action: #selector(avatarTapped))
        avatarImageView.isUserInteractionEnabled = true
        avatarImageView.addGestureRecognizer(avatarTap)
    }
    
    @objc private func avatarTapped() {
        let memojiVC = MemojiPickerViewController { [weak self] image in
            self?.avatarImageView.image = image
            
            // 更新用户头像
            if var user = User.loadFromKeychain() {
                // 从选中的图片名称中获取头像ID
                if let avatarName = image.accessibilityIdentifier {
                    user = User(id: user.id, name: user.name, avatar: avatarName, coins: user.coins)
                    user.saveToKeychain()
                }
            }
        }
        let navVC = UINavigationController(rootViewController: memojiVC)
        present(navVC, animated: true)
    }
    
    @objc private func refreshNameTapped() {
        // 显示加载指示器
        let loadingAlert = UIAlertController(title: nil, message: "正在生成新名字...", preferredStyle: .alert)
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = .medium
        loadingIndicator.startAnimating()
        loadingAlert.view.addSubview(loadingIndicator)
        present(loadingAlert, animated: true)
        
        // 调用智谱接口生成新名字
        ZhipuAIService.shared.sendMessage("帮我取一个2～6位的中文名字") { [weak self] result in
            guard let self = self else { return }
            
            // 关闭加载提示
            loadingAlert.dismiss(animated: true) {
                switch result {
                case .success(let response):
                    // 清理可能的多余字符，只保留中文名字
                    let name = response.trimmingCharacters(in: .whitespacesAndNewlines)
                        .components(separatedBy: CharacterSet.letters.union(.whitespaces).inverted)
                        .joined()
                        .prefix(6)
                        .trimmingCharacters(in: .whitespaces)
                    
                    // 如果获取到的名字符合要求
                    if name.count >= 2 {
                        // 显示确认对话框
                        let confirmAlert = UIAlertController(
                            title: "确认更换名字",
                            message: "是否将名字更换为：\(name)？",
                            preferredStyle: .alert
                        )
                        
                        // 确认按钮
                        confirmAlert.addAction(UIAlertAction(title: "确定", style: .default) { [weak self] _ in
                            guard let self = self else { return }
                            // 更新用户信息
                            if var user = User.loadFromKeychain() {
                                user = User(id: user.id, name: String(name), avatar: user.avatar, coins: user.coins)
                                user.saveToKeychain()
                                
                                // 更新UI
                                self.nameLabel.text = name
                                
                                // 显示成功提示
                                let successAlert = UIAlertController(
                                    title: "更换成功",
                                    message: "名字已更换为：\(name)",
                                    preferredStyle: .alert
                                )
                                successAlert.addAction(UIAlertAction(title: "好的", style: .default))
                                self.present(successAlert, animated: true)
                            }
                        })
                        
                        // 取消按钮
                        confirmAlert.addAction(UIAlertAction(title: "取消", style: .cancel))
                        
                        self.present(confirmAlert, animated: true)
                    } else {
                        // 名字不符合要求
                        self.showNameError(message: "生成的名字不符合要求，请重试")
                    }
                    
                case .failure(let error):
                    // 显示错误提示
                    self.showNameError(message: "生成名字失败：\(error.localizedDescription)")
                }
            }
        }
    }
    
    private func showNameError(message: String) {
        let alert = UIAlertController(
            title: "提示",
            message: message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "重试", style: .default) { [weak self] _ in
            self?.refreshNameTapped()
        })
        alert.addAction(UIAlertAction(title: "取消", style: .cancel))
        present(alert, animated: true)
    }
    
    // MARK: - Cache Management
    private func handleClearCache() {
        let alert = UIAlertController(
            title: "清除缓存",
            message: "确定要清除缓存吗？",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "取消", style: .cancel))
        alert.addAction(UIAlertAction(title: "确定", style: .destructive) { [weak self] _ in
            // 模拟清理缓存
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                let successAlert = UIAlertController(
                    title: "清理完成",
                    message: "缓存已清理",
                    preferredStyle: .alert
                )
                successAlert.addAction(UIAlertAction(title: "好的", style: .default))
                self?.present(successAlert, animated: true)
            }
        })
        
        present(alert, animated: true)
    }
}

// MARK: - UITableViewDelegate & DataSource
extension UserViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as! UserMenuCell
        let item = sections[indexPath.section][indexPath.row]
        cell.configure(with: item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        header.backgroundColor = .clear
        
        let label = UILabel()
        label.text = sectionTitles[section]
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .gray
        
        header.addSubview(label)
        label.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12)
            make.bottom.equalToSuperview().offset(-8)
        }
        
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let item = sections[indexPath.section][indexPath.row]
        
        switch item.title {
        case "清除缓存":
            handleClearCache()
        case "消息通知":
            let notificationVC = NotificationSettingsViewController()
            notificationVC.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(notificationVC, animated: true)
        case "帮助中心":
            let helpVC = HelpCenterViewController()
            helpVC.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(helpVC, animated: true)
        case "意见反馈":
            let feedbackVC = FeedbackViewController()
            feedbackVC.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(feedbackVC, animated: true)
        case "隐私政策":
            let privacyVC = PrivacyPolicyViewController()
            privacyVC.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(privacyVC, animated: true)
        case "责任声明":
            let disclaimerVC = DisclaimerViewController()
            disclaimerVC.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(disclaimerVC, animated: true)
        case "关于我们":
            let aboutVC = AboutUsViewController()
            aboutVC.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(aboutVC, animated: true)
        default:
            break
        }
    }
}



