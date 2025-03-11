import UIKit
import SnapKit

class NotificationSettingsViewController: UIViewController {
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    private let sections = [
        ("消息提醒", [
            ("每日心情提醒", true),
            ("AI互动提醒", true),
            ("探索更新提醒", true)
        ]),
        ("提醒方式", [
            ("声音", true),
            ("震动", true),
            ("横幅通知", true)
        ])
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        title = "消息通知"
        view.backgroundColor = .systemGroupedBackground
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension NotificationSettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].1.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let item = sections[indexPath.section].1[indexPath.row]
        
        cell.textLabel?.text = item.0
        
        let toggle = UISwitch()
        toggle.isOn = item.1
        toggle.tag = indexPath.section * 100 + indexPath.row
        toggle.addTarget(self, action: #selector(switchChanged(_:)), for: .valueChanged)
        cell.accessoryView = toggle
        
        return cell
    }
    
    @objc private func switchChanged(_ sender: UISwitch) {
        // 这里可以处理开关状态变化
        // 可以保存到 UserDefaults 或发送到服务器
    }
} 