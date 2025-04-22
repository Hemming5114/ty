import UIKit
import SnapKit
import SafariServices

class LaunchViewController: UIViewController {
    private let launchImageView = UIImageView()
    private let agreementCheckbox = UIButton()
    private let startButton = UIButton()
    private let agreementStack = UIStackView()
    
    private var isAgreed = false {
        didSet {
            startButton.backgroundColor = isAgreed ? TYConstants.UI.themeColor : TYConstants.UI.Button.disabledColor
        }
    }
    
    private var isShaking = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        setupLaunchImage()
        setupAgreementStack()
        setupStartButton()
    }
    
    private func setupLaunchImage() {
        view.addSubview(launchImageView)
        launchImageView.image = UIImage(named: "LaunchImage")
        launchImageView.contentMode = .scaleAspectFill
        
        launchImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupAgreementStack() {
        // 创建协议按钮
        let userAgreementButton = createLinkButton(title: "《用户协议》")
        let privacyPolicyButton = createLinkButton(title: "《隐私政策》")
        
        // 创建说明文本
        let descLabel = UILabel()
        descLabel.text = "请阅读并同意"
        descLabel.textColor = .darkGray
        descLabel.font = TYConstants.UI.Font.caption
        
        let andLabel = UILabel()
        andLabel.text = "和"
        andLabel.textColor = .darkGray
        andLabel.font = TYConstants.UI.Font.caption
        
        // 设置复选框
        agreementCheckbox.setImage(UIImage(systemName: "square"), for: .normal)
        agreementCheckbox.setImage(UIImage(systemName: "checkmark.square.fill"), for: .selected)
        agreementCheckbox.tintColor = TYConstants.UI.themeColor
        agreementCheckbox.addTarget(self, action: #selector(checkboxTapped), for: .touchUpInside)
        
        // 创建水平布局的Stack View
        agreementStack.axis = .horizontal
        agreementStack.alignment = .center
        agreementStack.spacing = 4
        agreementStack.addArrangedSubview(agreementCheckbox)
        agreementStack.addArrangedSubview(descLabel)
        agreementStack.addArrangedSubview(userAgreementButton)
        agreementStack.addArrangedSubview(andLabel)
        agreementStack.addArrangedSubview(privacyPolicyButton)
        
        view.addSubview(agreementStack)
        
        agreementStack.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-100)
        }
    }
    
    private func setupStartButton() {
        view.addSubview(startButton)
        
        startButton.setTitle("立即体验", for: .normal)
        startButton.backgroundColor = TYConstants.UI.Button.disabledColor
        startButton.layer.cornerRadius = TYConstants.UI.mainCornerRadius
        startButton.titleLabel?.font = TYConstants.UI.Font.title
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        
        startButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-TYConstants.UI.Padding.large)
            make.leading.trailing.equalToSuperview().inset(TYConstants.UI.Padding.large)
            make.height.equalTo(TYConstants.UI.Button.height)
        }
    }
    
    private func createLinkButton(title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.setTitleColor(TYConstants.UI.themeColor, for: .normal)
        button.titleLabel?.font = TYConstants.UI.Font.caption
        button.addTarget(self, action: #selector(linkButtonTapped(_:)), for: .touchUpInside)
        return button
    }
    
    // MARK: - Actions
    @objc private func checkboxTapped() {
        agreementCheckbox.isSelected.toggle()
        isAgreed = agreementCheckbox.isSelected
    }
    
    @objc private func linkButtonTapped(_ sender: UIButton) {
        let urlString: String
        let title: String
        
        if sender.title(for: .normal)?.contains("用户协议") == true {
            urlString = TYConstants.WebURL.userAgreement
            title = "用户协议"
        } else {
            urlString = TYConstants.WebURL.privacyPolicy
            title = "隐私政策"
        }
        
        let webVC = WebViewController(title: title, urlString: urlString)
        let navVC = UINavigationController(rootViewController: webVC)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true)
    }
    
    @objc private func startButtonTapped() {
        if !isAgreed {
            shakeAgreementStack()
            return
        }
        UIDevice.getDeviceIdentifier { devideStr in }
        self.handleUserCreation()
        
    }
    
    private func handleUserCreation() {
        // 显示加载指示器
        let loadingView = UIActivityIndicatorView(style: .medium)
        loadingView.color = .white
        startButton.setTitle("", for: .normal)
        startButton.addSubview(loadingView)
        loadingView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        loadingView.startAnimating()
        startButton.isEnabled = false
        
        User.generateNewUser { [weak self] result in
            guard let self = self else { return }
            
            // 恢复按钮状态
            loadingView.removeFromSuperview()
            self.startButton.setTitle("立即体验", for: .normal)
            self.startButton.isEnabled = true
            
            switch result {
            case .success(let user):
                user.saveToKeychain()
                
                // 检查今天是否已经选择过心情
                if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                    if appDelegate.shouldShowMoodSelection() {
                        // 显示心情选择页面
                        let moodVC = MoodSelectionViewController()
                        let navVC = UINavigationController(rootViewController: moodVC)
                        navVC.modalPresentationStyle = .fullScreen
                        self.present(navVC, animated: true)
                    } else {
                        // 获取上次选择的心情，如果没有则默认为 happy
                        let lastMood = UserDefaults.standard.string(forKey: TYConstants.UserDefaults.lastSelectedMood) ?? "happy"
                        appDelegate.setupMainTabBarController(with: lastMood)
                    }
                }
                
            case .failure(let error):
                // 显示错误提示
                let alert = UIAlertController(
                    title: "创建用户失败",
                    message: error.localizedDescription,
                    preferredStyle: .alert
                )
                alert.addAction(UIAlertAction(title: "确定", style: .default))
                self.present(alert, animated: true)
            }
        }
    }
    
    private func shakeAgreementStack() {
        guard !isShaking else { return }
        isShaking = true
        
        // 高亮显示协议文本
        agreementStack.subviews.forEach { view in
            if let button = view as? UIButton,
               button.title(for: .normal)?.contains("《") == true {
                button.setTitleColor(.red, for: .normal)
            }
        }
        
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: .linear)
        animation.duration = TYConstants.UI.Animation.duration
        animation.values = TYConstants.UI.Animation.shakeValues
        
        agreementStack.layer.add(animation, forKey: "shake")
        
        // 恢复原来的颜色
        DispatchQueue.main.asyncAfter(deadline: .now() + TYConstants.UI.Animation.duration) { [weak self] in
            guard let self = self else { return }
            self.agreementStack.subviews.forEach { view in
                if let button = view as? UIButton,
                   button.title(for: .normal)?.contains("《") == true {
                    button.setTitleColor(TYConstants.UI.themeColor, for: .normal)
                }
            }
            self.isShaking = false
        }
    }
} 
