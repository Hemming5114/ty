import UIKit
import SnapKit

class ContactUsViewController: UIViewController {
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    private let contacts = [
        ("官方邮箱", "support@example.com"),
        ("官方微信", "ExampleOfficial"),
        ("商务合作", "business@example.com"),
        ("用户反馈", "feedback@example.com")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        title = "联系我们"
        view.backgroundColor = .systemGroupedBackground
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension ContactUsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let contact = contacts[indexPath.row]
        
        if #available(iOS 14.0, *) {
            var config = cell.defaultContentConfiguration()
            config.text = contact.0
            config.secondaryText = contact.1
            cell.contentConfiguration = config
        } else {
            cell.textLabel?.text = contact.0
            cell.detailTextLabel?.text = contact.1
        }
       
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let contact = contacts[indexPath.row]
        UIPasteboard.general.string = contact.1
        
        // 显示复制成功提示
        let alert = UIAlertController(title: "已复制", message: nil, preferredStyle: .alert)
        present(alert, animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            alert.dismiss(animated: true)
        }
    }
} 
