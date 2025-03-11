import UIKit
import SnapKit

class SettingsViewController: UIViewController {
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    private let sections: [[SettingItem]] = [
        [
            SettingItem(icon: "bell", title: "通知设置", type: .toggle),
            SettingItem(icon: "moon", title: "深色模式", type: .toggle)
        ],
        [
            SettingItem(icon: "doc.text", title: "用户协议", type: .arrow),
            SettingItem(icon: "hand.raised", title: "隐私政策", type: .arrow),
            SettingItem(icon: "info.circle", title: "关于我们", type: .arrow)
        ],
        [
            SettingItem(icon: "arrow.right.square", title: "退出登录", type: .none)
        ]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        title = "设置"
        view.backgroundColor = .systemGroupedBackground
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SettingCell.self, forCellReuseIdentifier: "SettingCell")
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - UITableViewDelegate & DataSource
extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingCell", for: indexPath) as! SettingCell
        let item = sections[indexPath.section][indexPath.row]
        cell.configure(with: item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let item = sections[indexPath.section][indexPath.row]
        switch item.title {
        case "退出登录":
            showLogoutAlert()
        case "用户协议":
            showWebView(title: "用户协议", urlString: TYConstants.WebURL.userAgreement)
        case "隐私政策":
            showWebView(title: "隐私政策", urlString: TYConstants.WebURL.privacyPolicy)
        case "关于我们":
            showAbout()
        default:
            break
        }
    }
    
    private func showLogoutAlert() {
        let alert = UIAlertController(
            title: "退出登录",
            message: "确定要退出登录吗？",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "取消", style: .cancel))
        alert.addAction(UIAlertAction(title: "确定", style: .destructive) { [weak self] _ in
            // 清除用户数据
            try? KeychainHelper.shared.clearAll()
            
            // 返回到登录页
            if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                appDelegate.switchRootViewController(to: LaunchViewController())
            }
        })
        
        present(alert, animated: true)
    }
    
    private func showWebView(title: String, urlString: String) {
        let webVC = WebViewController(title: title, urlString: urlString)
        navigationController?.pushViewController(webVC, animated: true)
    }
    
    private func showAbout() {
        let alert = UIAlertController(
            title: "关于我们",
            message: "桃遇 v1.0.0\n一个有趣的AI聊天应用",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "确定", style: .default))
        present(alert, animated: true)
    }
} 