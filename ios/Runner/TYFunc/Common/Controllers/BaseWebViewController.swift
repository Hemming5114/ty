import WebKit
class BaseWebViewController: UIViewController {
    private let webView = WKWebView()
    private let url: URL
    
    init(url: URL) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadContent()
    }
    
    private func setupUI() {
        view.addSubview(webView)
        webView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func loadContent() {
        webView.load(URLRequest(url: url))
    }
} 
