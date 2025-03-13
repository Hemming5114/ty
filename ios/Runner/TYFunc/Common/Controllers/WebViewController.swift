import UIKit
import WebKit
import SnapKit

class WebViewController: UIViewController {
    private let webView = WKWebView()
    private let titleString: String
    private let urlString: String
    private let isPushed: Bool

    init(title: String, urlString: String, isPushed: Bool = false) {        self.titleString = title
        self.urlString = urlString
        self.isPushed = isPushed
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadWebContent()
    }
    
    private func setupUI() {
        title = titleString
        view.backgroundColor = .white
        
        // 设置导航栏
        let closeButton = UIBarButtonItem(
            image: UIImage(systemName: isPushed ? "chevron.left" : "xmark"),            style: .plain,
            target: self,
            action: #selector(closeButtonTapped)
        )
        // 设置关闭按钮颜色为主题色
        closeButton.tintColor = TYConstants.UI.themeColor
        navigationItem.leftBarButtonItem = closeButton
        
        // 设置导航栏标题颜色
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: TYConstants.UI.themeColor
        ]
        
        // 设置WebView
        view.addSubview(webView)
        webView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func loadWebContent() {
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    @objc private func closeButtonTapped() {
        if isPushed {
            navigationController?.popViewController(animated: true)
        } else {
            dismiss(animated: true)
        }

    }
} 
