import UIKit
import SnapKit
import IQKeyboardManagerSwift

class ChatViewController: UIViewController {
    private let session: ChatSession
    private let tableView = UITableView()
    private let chatInputView = ChatInputView()
    private var messages: [ChatMessage]
    private var keyboardHeight: CGFloat = 0
    private let backgroundImageView = UIImageView()
    private let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
    
    private let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        return view
    }()
    
    private let avatarButton: UIButton = {
        let button = UIButton(type: .system)
        button.imageView?.contentMode = .scaleAspectFill
        button.clipsToBounds = true
        button.layer.cornerRadius = 25 // 头像大小的一半
        return button
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    
    init(session: ChatSession) {
        self.session = session
        self.messages = session.messages
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupActions()
        
        // 如果是新会话，添加开场白
        if messages.isEmpty {
            let openingMessage = ChatMessage(
                content: ChatManager.shared.getOpeningMessage(for: session.aiModel),
                type: .system,
                role: .assistant
            )
            messages.append(openingMessage)
            updateSession()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        scrollToBottom(animated: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 启用 IQKeyboardManager
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // 禁用 IQKeyboardManager
        IQKeyboardManager.shared.enable = false
        IQKeyboardManager.shared.enableAutoToolbar = false
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        // 设置导航栏
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "exclamationmark.triangle"),
            style: .plain,
            target: self,
            action: #selector(reportButtonTapped)
        )
        navigationItem.rightBarButtonItem?.tintColor = TYConstants.UI.themeColor
        
        // 添加头部视图
        view.addSubview(headerView)
        headerView.addSubview(avatarButton)
        headerView.addSubview(nameLabel)
        
        // 设置背景
        backgroundImageView.image = UIImage(named: session.aiModel.avatarImageName)
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.clipsToBounds = true
        view.addSubview(backgroundImageView)
        
        // 调整毛玻璃效果的透明度
        blurView.alpha = 0.95  // 调整透明度使背景更清晰
        view.addSubview(blurView)
        
        // 设置输入框区域背景
        let inputBackground = UIView()
        inputBackground.backgroundColor = .white
        view.addSubview(inputBackground)
        
        // 设置 tableView 背景色为透明
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(ChatMessageCell.self, forCellReuseIdentifier: "MessageCell")
        tableView.keyboardDismissMode = .interactive
        tableView.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0)
        view.addSubview(tableView)
        
        chatInputView.delegate = self
        view.addSubview(chatInputView)
        
        // 布局
        headerView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(64)
        }
        
        avatarButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(50)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.left.equalTo(avatarButton.snp.right).offset(12)
            make.centerY.equalTo(avatarButton)
        }
        
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        blurView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(chatInputView.snp.top)
        }
        
        // 输入框背景延伸到底部
        inputBackground.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(chatInputView.snp.top)
        }
        
        chatInputView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func setupActions() {
        avatarButton.addTarget(self, action: #selector(avatarButtonTapped), for: .touchUpInside)
    }
    
    private func configureContent() {
        // 设置 AI 信息
        avatarButton.setImage(UIImage(named: session.aiModel.avatarImageName), for: .normal)
        nameLabel.text = session.aiModel.name
        
        // ... 其他配置保持不变 ...
    }
    
    private func updateSession() {
        var updatedSession = session
        updatedSession.messages = messages
        updatedSession.lastMessageAt = Date()
        ChatManager.shared.saveSession(updatedSession)
    }
    
    private func scrollToBottom(animated: Bool = true) {
        guard !messages.isEmpty else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            let lastIndex = IndexPath(row: self.messages.count - 1, section: 0)
            self.tableView.scrollToRow(at: lastIndex, at: .bottom, animated: animated)
        }
    }
    
    // MARK: - Actions
    @objc private func avatarButtonTapped() {
        let detailVC = AIDetailViewController(ai: session.aiModel)
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    @objc private func reportButtonTapped() {
        let reportVC = ReportViewController(ai: session.aiModel)
        navigationController?.pushViewController(reportVC, animated: true)
    }
}

// MARK: - UITableViewDelegate & DataSource
extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as! ChatMessageCell
        let message = messages[indexPath.row]
        let showTime = shouldShowTime(for: indexPath)
        cell.configure(with: message, showTime: showTime, aiAvatar: session.aiModel.avatarImageName)
        return cell
    }
    
    private func shouldShowTime(for indexPath: IndexPath) -> Bool {
        if indexPath.row == 0 { return true }
        
        let currentMessage = messages[indexPath.row]
        let previousMessage = messages[indexPath.row - 1]
        
        let calendar = Calendar.current
        return !calendar.isDate(currentMessage.timestamp, equalTo: previousMessage.timestamp, toGranularity: .minute)
    }
}

// MARK: - ChatInputViewDelegate
extension ChatViewController: ChatInputViewDelegate {
    func chatInputView(_ inputView: ChatInputView, didSendMessage text: String) {
        // 添加用户消息
        let userMessage = ChatMessage(content: text, role: .user)
        messages.append(userMessage)
        updateSession()
        
        // 更新UI
        tableView.reloadData()
        scrollToBottom()
        
        // 发送到AI
        ZhipuAIService.shared.sendMessage(text) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let response):
                let aiMessage = ChatMessage(content: response, role: .assistant)
                self.messages.append(aiMessage)
                self.updateSession()
                self.tableView.reloadData()
                self.scrollToBottom()
                
            case .failure(let error):
                let errorMessage = ChatMessage(
                    content: "抱歉，我遇到了一些问题：\(error.localizedDescription)",
                    type: .system,
                    role: .assistant
                )
                self.messages.append(errorMessage)
                self.updateSession()
                self.tableView.reloadData()
                self.scrollToBottom()
            }
        }
    }
} 
