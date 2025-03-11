import UIKit
import SnapKit
import MJRefresh

class AIListViewController: UIViewController {
    private let collectionView: UICollectionView
    private var aiModels: [AIModel] = []
    private let currentMood: String
    private let emptyView = EmptyStateView(message: "暂无推荐的AI")
    private let moodButton = UIButton()
    
    init(mood: String) {
        self.currentMood = mood
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        #if DEBUG
        createAIDirectory() // 仅在调试时创建目录
        #endif
        loadAIModels()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemGray6
        
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(AIListCell.self, forCellWithReuseIdentifier: "AICell")
        
        // 设置 MJRefresh
        collectionView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(refreshData))
        // 自定义下拉刷新样式
        if let header = collectionView.mj_header as? MJRefreshNormalHeader {
            header.stateLabel?.textColor = TYConstants.UI.themeColor
            header.lastUpdatedTimeLabel?.textColor = TYConstants.UI.themeColor
            header.loadingView?.color = TYConstants.UI.themeColor
        }
        
        view.addSubview(collectionView)
        view.addSubview(emptyView)
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        emptyView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
        }
        
        emptyView.isHidden = true
        
        // 添加心情切换按钮
        moodButton.setImage(UIImage(systemName: "heart.circle.fill"), for: .normal)
        moodButton.tintColor = TYConstants.UI.themeColor
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: moodButton)
        moodButton.addTarget(self, action: #selector(moodButtonTapped), for: .touchUpInside)
    }
    
    @objc private func moodButtonTapped() {
        let moodVC = MoodSelectionViewController()
        let navVC = UINavigationController(rootViewController: moodVC)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true)
    }
    
    @objc private func refreshData() {
        // 随机打乱现有数据
        aiModels.shuffle()
        collectionView.reloadData()
        
        // 添加一些动画效果
        let animation = CATransition()
        animation.type = .fade
        animation.duration = 0.3
        collectionView.layer.add(animation, forKey: "fadeAnimation")
        
        // 结束刷新
        collectionView.mj_header?.endRefreshing()
    }
    
    private func loadAIModels() {
        print("Current mood: \(currentMood)")
        
        // 首先尝试从 Resources/AI 目录加载
        if let path = Bundle.main.path(forResource: currentMood, ofType: "json", inDirectory: "Resources/AI"),
           let data = try? Data(contentsOf: URL(fileURLWithPath: path)) {
            do {
                let aiGroup = try JSONDecoder().decode(AIMoodGroup.self, from: data)
                // 初次加载时也随机打乱顺序
                aiModels = aiGroup.models.shuffled()
                emptyView.isHidden = !aiModels.isEmpty
                collectionView.reloadData()
                return
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }
        
        // 如果失败，尝试直接从根目录加载
        if let path = Bundle.main.path(forResource: currentMood, ofType: "json"),
           let data = try? Data(contentsOf: URL(fileURLWithPath: path)) {
            do {
                let aiGroup = try JSONDecoder().decode(AIMoodGroup.self, from: data)
                // 初次加载时也随机打乱顺序
                aiModels = aiGroup.models.shuffled()
                emptyView.isHidden = !aiModels.isEmpty
                collectionView.reloadData()
                return
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }
        
        print("Failed to load JSON file for mood: \(currentMood)")
        emptyView.isHidden = false
    }
    
    private func createAIDirectory() {
        let fileManager = FileManager.default
        guard let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return
        }
        
        let aiDirectory = documentDirectory.appendingPathComponent("AI")
        
        do {
            try fileManager.createDirectory(at: aiDirectory, withIntermediateDirectories: true)
            
            // 复制 JSON 文件
            if let sourcePath = Bundle.main.path(forResource: currentMood, ofType: "json") {
                let destinationPath = aiDirectory.appendingPathComponent("\(currentMood).json")
                try fileManager.copyItem(atPath: sourcePath, toPath: destinationPath.path)
            }
        } catch {
            print("Failed to create AI directory: \(error)")
        }
    }
}

// MARK: - UICollectionViewDelegate & DataSource
extension AIListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return aiModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AICell", for: indexPath) as! AIListCell
        cell.configure(with: aiModels[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width - 32
        return CGSize(width: width, height: 160)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedAI = aiModels[indexPath.item]
        let detailVC = AIDetailViewController(ai: selectedAI)
        pushWithHiddenTabBar(detailVC)
    }
} 
