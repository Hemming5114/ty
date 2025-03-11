import UIKit
import SnapKit

class ExploreViewController: UIViewController {
    private let collectionView: UICollectionView
    private var sections: [ExploreSection] = []
    
    // 顶部背景渐变
    private let gradientLayer = CAGradientLayer()
    
    private let musicButton = UIButton()
    private let musicService = MusicService.shared
    
    private var rotationAnimation: CABasicAnimation?
    
    init() {
        let layout = UICollectionViewCompositionalLayout { section, env in
            switch section {
            case 0: // 探索
                return ExploreLayoutSection.exploreSection()
            default:
                return nil
            }
        }
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupData()
        setupMusicButton()
        setupNotifications()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 只恢复动画，不恢复播放
        if musicService.isPlaying {
            startMusicAnimation()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // 只停止动画，不暂停播放
        stopMusicAnimation()
    }
    
    private func setupUI() {
        title = "探索"
        view.backgroundColor = .systemBackground
        
        // 设置渐变背景
        gradientLayer.colors = [
            UIColor(red: 1, green: 0.9, blue: 0.9, alpha: 1).cgColor,
            UIColor.white.cgColor
        ]
        gradientLayer.locations = [0, 1]
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        // 设置集合视图
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ExploreCell.self, forCellWithReuseIdentifier: "ExploreCell")
        collectionView.register(
            ExploreHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "HeaderView"
        )
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer.frame = view.bounds
    }
    
    private func setupData() {
        // 探索数据
        let explores = [
            ExploreItem(title: "今日探索", description: "探索今天的缘分"),
            ExploreItem(title: "本周探索", description: "发现一周的美好"),
            ExploreItem(title: "本月探索", description: "遇见命中注定"),
            ExploreItem(title: "趣味探索", description: "探索你的想法")
        ]
        
        sections = [
            ExploreSection(type: .explore, items: explores)
        ]
        
        collectionView.reloadData()
    }
    
    private func setupMusicButton() {
        musicButton.setImage(UIImage(systemName: "music.note"), for: .normal)
        musicButton.tintColor = TYConstants.UI.themeColor
        musicButton.addTarget(self, action: #selector(musicButtonTapped), for: .touchUpInside)
        
        let musicBarButton = UIBarButtonItem(customView: musicButton)
        navigationItem.rightBarButtonItem = musicBarButton
        
        // 如果音乐正在播放，启动动画
        if musicService.isPlaying {
            startMusicAnimation()
        }
    }
    
    private func startMusicAnimation() {
        // 移除现有动画
        musicButton.layer.removeAnimation(forKey: "rotation")
        
        // 创建旋转动画
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.fromValue = 0
        animation.toValue = CGFloat.pi * 2
        animation.duration = 3.0
        animation.repeatCount = .infinity
        animation.isRemovedOnCompletion = false
        
        // 保存动画引用以便后续控制
        rotationAnimation = animation
        
        // 添加动画
        musicButton.layer.add(animation, forKey: "rotation")
    }
    
    private func stopMusicAnimation() {
        musicButton.layer.removeAnimation(forKey: "rotation")
    }
    
    @objc private func musicButtonTapped() {
        let musicVC = MusicSelectionViewController()
        pushWithHiddenTabBar(musicVC)
    }
    
    private func setupNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleMusicStateChange(_:)),
            name: MusicService.musicStateDidChangeNotification,
            object: nil
        )
    }
    
    @objc private func handleMusicStateChange(_ notification: Notification) {
        if let isPlaying = notification.userInfo?["isPlaying"] as? Bool {
            if isPlaying {
                startMusicAnimation()
            } else {
                stopMusicAnimation()
            }
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: - UICollectionViewDelegate & DataSource
extension ExploreViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[section].items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = sections[indexPath.section]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExploreCell", for: indexPath) as! ExploreCell
        let item = section.items[indexPath.item] as! ExploreItem
        cell.configure(with: item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: "HeaderView",
            for: indexPath
        ) as! ExploreHeaderView
        
        let section = sections[indexPath.section]
        header.configure(with: section.type.title)
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let section = sections[indexPath.section]
        let item = section.items[indexPath.item] as! ExploreItem
        
        if item.title == "趣味探索" {
            let customVC = CustomExploreViewController()
            pushWithHiddenTabBar(customVC)
        } else {
            let exploreVC = ExploreDetailViewController(explore: item)
            pushWithHiddenTabBar(exploreVC)
        }
    }
} 
