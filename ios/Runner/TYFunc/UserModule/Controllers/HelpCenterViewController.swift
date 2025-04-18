import UIKit
import SnapKit

class HelpCenterViewController: UIViewController {
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    // 帮助内容分类
    private let sections = [
        ("基础功能", [
            ("每日心情", "每天登录后可以选择当前的心情状态，系统会根据您的心情推荐合适的AI助手。"),
            ("背景音乐", "应用提供AI生成的轻音乐作为背景音乐，可以在探索页面右上角控制音乐播放，或进入音乐选择页面切换不同的音乐。"),
            ("遇见AI", "根据您的心情，系统会推荐不同性格的AI助手，每个AI助手都有独特的个性和专长。")
        ]),
        ("探索功能", [
            ("今日探索", "每天都会更新新的探索内容，发现生活中的美好瞬间。"),
            ("本周探索", "回顾这一周的心情变化，找到让自己开心的时刻。"),
            ("本月探索", "月度情绪报告，帮助您更好地了解自己。"),
            ("趣味探索", "可以和AI进行各种有趣的互动，获得独特的见解。")
        ]),
        ("聊天功能", [
            ("对话记录", "系统会保存您与AI助手的对话记录，方便您随时回顾。"),
            ("情感分析", "AI会分析对话内容，理解您的情绪变化。"),
            ("隐私保护", "所有对话内容都经过加密处理，确保您的隐私安全。")
        ]),
        ("其他说明", [
            ("音乐版权", "所有背景音乐均由AI生成，不存在版权问题，仅供个人使用。"),
            ("使用建议", "建议每天记录心情，保持与AI助手的交流，帮助自己更好地认识自己。"),
            ("安全提醒", "请勿在对话中透露个人敏感信息，保护好自己的隐私。")
        ])
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        title = "帮助中心"
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

extension HelpCenterViewController: UITableViewDelegate, UITableViewDataSource {
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
        
        if #available(iOS 14.0, *) {
            var config = cell.defaultContentConfiguration()
            config.text = item.0
            config.secondaryText = item.1
            config.secondaryTextProperties.numberOfLines = 0
            config.secondaryTextProperties.color = .systemGray
            cell.contentConfiguration = config
            
        } else {
            cell.textLabel?.text =  item.0
            cell.detailTextLabel?.text =  item.0
            // Fallback on earlier versions
        }
        
        cell.selectionStyle = .none
        
        return cell
    }
} 
