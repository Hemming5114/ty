import UIKit
import SnapKit

class ReportViewController: UIViewController {
    private let ai: AIModel
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    private let reportReasonTextView = UITextView()
    private let submitButton = UIButton()
    
    private let reportReasons = [
        "不当言论",
        "违法内容",
        "色情暴力",
        "虚假信息",
        "其他原因"
    ]
    
    private var selectedReason: String?
    
    init(ai: AIModel) {
        self.ai = ai
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        title = "举报"
        view.backgroundColor = .systemGroupedBackground
        
        // 设置表格视图
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.isScrollEnabled = false
        
        // 设置文本输入框
        reportReasonTextView.font = TYConstants.UI.Font.body
        reportReasonTextView.textColor = .black
        reportReasonTextView.layer.cornerRadius = 8
        reportReasonTextView.backgroundColor = .white
        reportReasonTextView.placeholder = "请输入具体原因（选填）"
        
        // 设置提交按钮
        submitButton.setTitle("提交", for: .normal)
        submitButton.backgroundColor = TYConstants.UI.Button.disabledColor
        submitButton.layer.cornerRadius = TYConstants.UI.mainCornerRadius
        submitButton.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
        submitButton.isEnabled = false
        
        // 添加视图
        view.addSubview(tableView)
        view.addSubview(reportReasonTextView)
        view.addSubview(submitButton)
        
        // 布局
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.right.equalToSuperview()
            make.height.equalTo(reportReasons.count * 44 + 40)
        }
        
        reportReasonTextView.snp.makeConstraints { make in
            make.top.equalTo(tableView.snp.bottom).offset(16)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(100)
        }
        
        submitButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-16)
            make.height.equalTo(44)
        }
    }
    
    @objc private func submitTapped() {
        guard let reason = selectedReason else { return }
        
        // 显示加载指示器
        let loadingAlert = UIAlertController(title: nil, message: "正在提交...", preferredStyle: .alert)
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = .medium
        loadingIndicator.startAnimating()
        loadingAlert.view.addSubview(loadingIndicator)
        present(loadingAlert, animated: true)
        
        // 模拟网络请求
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            loadingAlert.dismiss(animated: true) {
                // 显示成功提示
                let alert = UIAlertController(
                    title: "提交成功",
                    message: "感谢您的反馈，我们会尽快处理",
                    preferredStyle: .alert
                )
                alert.addAction(UIAlertAction(title: "确定", style: .default) { _ in
                    self?.navigationController?.popViewController(animated: true)
                })
                self?.present(alert, animated: true)
            }
        }
    }
}

// MARK: - UITableViewDelegate & DataSource
extension ReportViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reportReasons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let reason = reportReasons[indexPath.row]
        cell.textLabel?.text = reason
        cell.accessoryType = reason == selectedReason ? .checkmark : .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedReason = reportReasons[indexPath.row]
        submitButton.isEnabled = true
        submitButton.backgroundColor = TYConstants.UI.themeColor
        tableView.reloadData()
    }
} 