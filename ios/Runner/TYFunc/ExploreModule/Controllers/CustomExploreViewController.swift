import UIKit
import SnapKit

class CustomExploreViewController: UIViewController {
    private let inputContainer = UIView()
    private let inputTextView = UITextView()
    private let placeholderLabel = UILabel()
    private let characterCountLabel = UILabel()
    private let exploreButton = UIButton()
    private let contentLabel = UILabel()
    private let loadingView = UIActivityIndicatorView(style: .medium)
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    // 顶部背景渐变
    private let gradientLayer = CAGradientLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        title = "趣味探索"
        view.backgroundColor = .white
        
        // 设置渐变背景
        gradientLayer.colors = [
            UIColor(red: 1, green: 0.9, blue: 0.9, alpha: 1).cgColor,
            UIColor.white.cgColor
        ]
        gradientLayer.locations = [0, 1]
        view.layer.insertSublayer(gradientLayer, at: 0)
        
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
        
        // 输入容器
        inputContainer.backgroundColor = .white
        inputContainer.layer.cornerRadius = 12
        inputContainer.layer.shadowColor = UIColor.black.cgColor
        inputContainer.layer.shadowOpacity = 0.1
        inputContainer.layer.shadowOffset = CGSize(width: 0, height: 2)
        inputContainer.layer.shadowRadius = 4
        contentView.addSubview(inputContainer)
        
        inputContainer.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.left.right.equalToSuperview().inset(20)
        }
        
        // 输入框
        inputTextView.font = TYConstants.UI.Font.body
        inputTextView.textColor = .black
        inputTextView.layer.cornerRadius = 8
        inputTextView.backgroundColor = .systemGray6
        inputTextView.delegate = self
        inputContainer.addSubview(inputTextView)
        
        // 占位符
        placeholderLabel.text = "请输入你想探索的内容..."
        placeholderLabel.font = TYConstants.UI.Font.body
        placeholderLabel.textColor = .systemGray3
        inputContainer.addSubview(placeholderLabel)
        
        // 字数统计
        characterCountLabel.font = TYConstants.UI.Font.caption
        characterCountLabel.textColor = .systemGray
        characterCountLabel.text = "0/50"
        inputContainer.addSubview(characterCountLabel)
        
        // 探索按钮
        exploreButton.setTitle("探索", for: .normal)
        exploreButton.setTitleColor(.white, for: .normal)
        exploreButton.backgroundColor = TYConstants.UI.themeColor
        exploreButton.layer.cornerRadius = 8
        exploreButton.addTarget(self, action: #selector(exploreTapped), for: .touchUpInside)
        inputContainer.addSubview(exploreButton)
        
        // 布局
        inputTextView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview().inset(12)
            make.height.equalTo(100)
        }
        
        placeholderLabel.snp.makeConstraints { make in
            make.left.equalTo(inputTextView).offset(5)
            make.top.equalTo(inputTextView).offset(8)
        }
        
        characterCountLabel.snp.makeConstraints { make in
            make.right.equalTo(inputTextView).offset(-5)
            make.bottom.equalTo(inputTextView).offset(-5)
        }
        
        exploreButton.snp.makeConstraints { make in
            make.top.equalTo(inputTextView.snp.bottom).offset(12)
            make.left.right.equalToSuperview().inset(12)
            make.height.equalTo(44)
            make.bottom.equalToSuperview().offset(-12)
        }
        
        // 内容标签
        contentLabel.font = TYConstants.UI.Font.body
        contentLabel.textColor = .black
        contentLabel.numberOfLines = 0
        contentView.addSubview(contentLabel)
        
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(inputContainer.snp.bottom).offset(20)
            make.left.right.bottom.equalToSuperview().inset(20)
        }
        
        // 加载指示器
        contentView.addSubview(loadingView)
        loadingView.snp.makeConstraints { make in
            make.center.equalTo(contentLabel)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer.frame = view.bounds
    }
    
    @objc private func exploreTapped() {
        guard let text = inputTextView.text?.trimmingCharacters(in: .whitespacesAndNewlines),
              !text.isEmpty else {
            return
        }
        
        view.endEditing(true)
        loadingView.startAnimating()
        contentLabel.text = nil
        exploreButton.isEnabled = false
        
        let prompt = "基于以下内容生成一段100-300字的探索桃运相关内容，要积极向上、富有希望：\(text)"
        ZhipuAIService.shared.sendMessage(prompt) { [weak self] result in
            DispatchQueue.main.async {
                self?.loadingView.stopAnimating()
                self?.exploreButton.isEnabled = true
                
                switch result {
                case .success(let content):
                    self?.contentLabel.text = content
                case .failure(let error):
                    self?.contentLabel.text = "获取探索内容失败：\(error.localizedDescription)"
                }
            }
        }
    }
}

// MARK: - UITextViewDelegate
extension CustomExploreViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !textView.text.isEmpty
        let count = textView.text.count
        characterCountLabel.text = "\(count)/50"
        
        if count > 50 {
            textView.text = String(textView.text.prefix(50))
        }
    }
} 
