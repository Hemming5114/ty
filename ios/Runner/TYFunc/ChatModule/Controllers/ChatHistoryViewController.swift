import UIKit
import SnapKit

class ChatHistoryViewController: UIViewController {
    // MARK: - Properties
    private let tableView = UITableView(frame: .zero, style: .plain)
    private let emptyView = EmptyStateView(message: "暂无聊天记录")
    private var allSessions: [ChatSession] = []
    private var uniqueSessions: [ChatSession] = [] // 存储合并后的会话
    
    // MARK: - UI Setup
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadSessions()
    }
    
    private func setupUI() {
        title = "回忆"
        view.backgroundColor = .white
        
        // 设置表格视图
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ChatSessionCell.self, forCellReuseIdentifier: "SessionCell")
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        
        // 添加视图
        view.addSubview(tableView)
        view.addSubview(emptyView)
        
        // 布局
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        emptyView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadSessions()
    }
    
    // MARK: - Data Management
    private func loadSessions() {
        // 从 ChatManager 加载所有会话
        allSessions = ChatManager.shared.getAllSessions()
        
        allSessions = allSessions.filter({ session in
            let isBlock = ChatManager.shared.blockSet.contains(session.aiModel.id)
            return !isBlock
        })

        
        // 按 AI ID 分组，每组只保留最新的一条会话
        let groupedSessions = Dictionary(grouping: allSessions) { (session: ChatSession) -> String in 
            return session.aiModel.id 
        }
        
        uniqueSessions = groupedSessions.compactMap { (aiID: String, sessions: [ChatSession]) -> ChatSession? in
            // 按时间戳排序，返回最新的会话
            return sessions.sorted { $0.lastMessageAt > $1.lastMessageAt }.first
        }.sorted { $0.lastMessageAt > $1.lastMessageAt }
        
        emptyView.isHidden = !uniqueSessions.isEmpty
        tableView.reloadData()
    }
}

// MARK: - UITableViewDelegate & DataSource
extension ChatHistoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return uniqueSessions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SessionCell", for: indexPath) as! ChatSessionCell
        cell.configure(with: uniqueSessions[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let session = uniqueSessions[indexPath.row]
        let chatVC = ChatViewController(session: session)
        pushWithHiddenTabBar(chatVC)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "删除") { [weak self] _, _, completion in
            guard let self = self else { return }
            
            let session = self.uniqueSessions[indexPath.row]
            
            // 删除该 AI 的所有会话
            self.allSessions.removeAll { $0.aiModel.id == session.aiModel.id }
            ChatManager.shared.saveSessions(self.allSessions)
            
            // 更新界面
            self.uniqueSessions.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            completion(true)
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
} 
