import UIKit
import SnapKit

class ExploreDetailViewController: UIViewController {
    private let explore: ExploreItem
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let contentLabel = UILabel()
    private let loadingView = UIActivityIndicatorView(style: .medium)
    private let refreshButton = UIButton()
    
    // 顶部背景渐变
    private let gradientLayer = CAGradientLayer()
    
    init(explore: ExploreItem) {
        self.explore = explore
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadExplore()
    }
    
    private func setupUI() {
        title = explore.title
        view.backgroundColor = .white
        
        // 设置渐变背景
        gradientLayer.colors = [
            UIColor(red: 1, green: 0.9, blue: 0.9, alpha: 1).cgColor,
            UIColor.white.cgColor
        ]
        gradientLayer.locations = [0, 1]
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        // 设置刷新按钮
        let refreshImage = UIImage(systemName: "arrow.clockwise")
        refreshButton.setImage(refreshImage, for: .normal)
        refreshButton.tintColor = TYConstants.UI.themeColor
        refreshButton.addTarget(self, action: #selector(refreshTapped), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: refreshButton)
        
        // 设置滚动视图
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(view)
        }
        
        // 设置内容标签
        contentLabel.font = TYConstants.UI.Font.body
        contentLabel.textColor = .black
        contentLabel.numberOfLines = 0
        contentView.addSubview(contentLabel)
        
        contentLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(20)
        }
        
        // 设置加载指示器
        contentView.addSubview(loadingView)
        loadingView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer.frame = view.bounds
    }
    
    private func loadExplore(useCache: Bool = true) {
        loadingView.startAnimating()
        contentLabel.text = nil
        refreshButton.isEnabled = false
        
        let service = FortuneService.shared
        
        switch explore.title {
        case "今日探索":
            if useCache {
                service.getDailyFortune { [weak self] result in
                    self?.handleExploreResult(result)
                }
            } else {
                service.generateFortune(type: "daily") { [weak self] result in
                    self?.handleExploreResult(result)
                }
            }
        case "本周探索":
            if useCache {
                service.getWeeklyFortune { [weak self] result in
                    self?.handleExploreResult(result)
                }
            } else {
                service.generateFortune(type: "weekly") { [weak self] result in
                    self?.handleExploreResult(result)
                }
            }
        case "本月探索":
            if useCache {
                service.getMonthlyFortune { [weak self] result in
                    self?.handleExploreResult(result)
                }
            } else {
                service.generateFortune(type: "monthly") { [weak self] result in
                    self?.handleExploreResult(result)
                }
            }
        default:
            break
        }
    }
    
    private func handleExploreResult(_ result: Result<String, Error>) {
        DispatchQueue.main.async { [weak self] in
            self?.loadingView.stopAnimating()
            self?.refreshButton.isEnabled = true
            
            switch result {
            case .success(let content):
                self?.contentLabel.text = content
            case .failure(let error):
                self?.contentLabel.text = "获取探索内容失败：\(error.localizedDescription)"
            }
        }
    }
    
    @objc private func refreshTapped() {
        // 刷新时不使用缓存
        loadExplore(useCache: false)
    }
} 
