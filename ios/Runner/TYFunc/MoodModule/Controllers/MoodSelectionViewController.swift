import UIKit
import SnapKit

class MoodSelectionViewController: UIViewController {
    
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let moodCollectionView: UICollectionView
    private let confirmButton = UIButton()
    
    private var selectedMood: Mood?
    private let moods = Mood.allMoods
    
    // MARK: - Initialization
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        moodCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupCollectionView()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        view.backgroundColor = .white
        
        // 设置标题
        titleLabel.text = "今天心情如何？"
        titleLabel.font = TYConstants.UI.Font.title
        titleLabel.textAlignment = .center
        view.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(TYConstants.UI.Padding.extraLarge)
            make.leading.trailing.equalToSuperview().inset(TYConstants.UI.Padding.large)
        }
        
        // 设置副标题
        subtitleLabel.text = "选择一个最符合当前心情的表情"
        subtitleLabel.font = TYConstants.UI.Font.subtitle
        subtitleLabel.textColor = .gray
        subtitleLabel.textAlignment = .center
        view.addSubview(subtitleLabel)
        
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(TYConstants.UI.Padding.normal)
            make.leading.trailing.equalToSuperview().inset(TYConstants.UI.Padding.large)
        }
        
        // 设置心情集合视图
        view.addSubview(moodCollectionView)
        moodCollectionView.backgroundColor = .clear
        
        moodCollectionView.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(TYConstants.UI.Padding.large)
            make.leading.trailing.equalToSuperview().inset(TYConstants.UI.Padding.large)
            make.height.equalTo(300)
        }
        
        // 设置确认按钮
        confirmButton.setTitle("确定", for: .normal)
        confirmButton.backgroundColor = TYConstants.UI.Button.disabledColor
        confirmButton.layer.cornerRadius = TYConstants.UI.mainCornerRadius
        confirmButton.titleLabel?.font = TYConstants.UI.Font.title
        confirmButton.isEnabled = false
        confirmButton.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
        view.addSubview(confirmButton)
        
        confirmButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-TYConstants.UI.Padding.extraLarge)
            make.leading.trailing.equalToSuperview().inset(TYConstants.UI.Padding.large)
            make.height.equalTo(TYConstants.UI.Button.height)
        }
    }
    
    private func setupCollectionView() {
        moodCollectionView.delegate = self
        moodCollectionView.dataSource = self
        moodCollectionView.register(MoodCollectionViewCell.self, forCellWithReuseIdentifier: "MoodCell")
        
        if let layout = moodCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.minimumInteritemSpacing = TYConstants.UI.Padding.normal
            layout.minimumLineSpacing = TYConstants.UI.Padding.normal
            
            // 计算每个item的大小
            let width = (view.bounds.width - TYConstants.UI.Padding.large * 2 - TYConstants.UI.Padding.normal * 2) / 3
            layout.itemSize = CGSize(width: width, height: width * 1.2)
        }
    }
    
    // MARK: - Actions
    @objc private func confirmButtonTapped() {
        guard let mood = selectedMood else { return }
        
        saveMoodSelection(mood: mood)
        
        // 发送通知
        NotificationCenter.default.post(
            name: TYConstants.NotificationNames.moodDidSelect,
            object: mood,
            userInfo: ["mood": mood.id]
        )
        
        // 关闭当前页面并切换到主页面
        dismiss(animated: true) { [weak self] in
            if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                appDelegate.setupMainTabBarController(with: mood.id)
            }
        }
    }
    
    private func saveMoodSelection(mood: Mood) {
        let defaults = UserDefaults.standard
        
        // 保存选择的心情
        defaults.set(mood.id, forKey: TYConstants.UserDefaults.lastSelectedMood)
        
        // 标记今天已经选择过心情
        defaults.set(true, forKey: TYConstants.UserDefaults.hasMoodSelectedToday)
        
        // 保存选择的时间
        defaults.set(Date(), forKey: TYConstants.UserDefaults.lastMoodSelectionDate)
        
        // 确保数据被保存
        defaults.synchronize()
    }
}

// MARK: - UICollectionViewDelegate & DataSource
extension MoodSelectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moods.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoodCell", for: indexPath) as! MoodCollectionViewCell
        cell.configure(with: moods[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedMood = moods[indexPath.item]
        confirmButton.isEnabled = true
        confirmButton.backgroundColor = TYConstants.UI.themeColor
        
        // 添加选中动画
        if let cell = collectionView.cellForItem(at: indexPath) as? MoodCollectionViewCell {
            UIView.animate(withDuration: 0.2) {
                cell.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            } completion: { _ in
                UIView.animate(withDuration: 0.2) {
                    cell.transform = .identity
                }
            }
        }
    }
} 