import UIKit
import SnapKit
import MJRefresh

class AIBlockViewController: UIViewController {
    
    private var aiModels: [AIModel] = []
    private let emptyView = EmptyStateView(message: "暂无拉黑的AI")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadAIModels()
    }
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 160
        tableView.register(BlockTableCell.self, forCellReuseIdentifier: "BlockTableCell")
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private func setupUI() {
        view.backgroundColor = .systemGray6
        view.addSubview(tableView)
        view.addSubview(emptyView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        emptyView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
        }
        emptyView.isHidden = true
    }
    
    private func loadAIModels() {
        
        // 首先尝试从 Resources/AI 目录加载
        if let path = Bundle.main.path(forResource: ChatManager.shared.currentMood, ofType: "json", inDirectory: "Resources/AI"),
           let data = try? Data(contentsOf: URL(fileURLWithPath: path)) {
            do {
                let aiGroup = try JSONDecoder().decode(AIMoodGroup.self, from: data)
                // 初次加载时也随机打乱顺序
                
                aiModels = aiGroup.models.filter({ model in
                    let isBlock = ChatManager.shared.blockSet.contains(model.id)
                    return isBlock
                })
                emptyView.isHidden = !aiModels.isEmpty
                tableView.reloadData()
                return
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }
        
        // 如果失败，尝试直接从根目录加载
        if let path = Bundle.main.path(forResource: ChatManager.shared.currentMood, ofType: "json"),
           let data = try? Data(contentsOf: URL(fileURLWithPath: path)) {
            do {
                let aiGroup = try JSONDecoder().decode(AIMoodGroup.self, from: data)
                // 初次加载时也随机打乱顺序
                
                aiModels = aiGroup.models.filter({ model in
                    let isBlock = ChatManager.shared.blockSet.contains(model.id)
                    return isBlock
                })
                emptyView.isHidden = !aiModels.isEmpty
                tableView.reloadData()
                return
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }
        emptyView.isHidden = false
    }
    
    private func removeBlock(aiID :String) {

        ChatManager.shared.removeBlockSession(aiID)
        aiModels = aiModels.filter({ model in
            let isBlock = ChatManager.shared.blockSet.contains(model.id)
            return isBlock
        })
        emptyView.isHidden = (aiModels.count > 0)
        tableView.reloadData()
        NotificationCenter.default.post(name: NSNotification.Name("UserBlockDidChangeNotification"), object: nil)

    }
    
}

// MARK: - UICollectionViewDelegate & DataSource
extension AIBlockViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return aiModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BlockTableCell") as! BlockTableCell
        cell.configure(with: aiModels[indexPath.item])
        return cell
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // 删除操作
        let deleteAction = UIContextualAction(style: .destructive, title: "取消拉黑") { (action, view, completionHandler) in
            // 执行删除操作
            let aiModel = self.aiModels[indexPath.item]
            self.removeBlock(aiID: aiModel.id)
            completionHandler(true)
        }
        // 返回配置
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = false // 是否允许全滑动触发第一个操作
        return configuration
    }
}

