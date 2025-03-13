class RechargeViewController: UIViewController {
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    private let products = Product.coinProducts
    private let headerView = UIView()
    private let coinsLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        title = "金币充值"
        view.backgroundColor = .systemGroupedBackground
        
        // 设置头部视图
        headerView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 100)
        headerView.backgroundColor = .clear
        
        coinsLabel.font = .systemFont(ofSize: 24, weight: .medium)
        coinsLabel.textColor = TYConstants.UI.themeColor
        coinsLabel.textAlignment = .center
        
        if let user = User.loadFromKeychain() {
            coinsLabel.text = "当前金币：\(user.coins)"
        }
        
        headerView.addSubview(coinsLabel)
        coinsLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        tableView.tableHeaderView = headerView
        tableView.register(RechargeCell.self, forCellReuseIdentifier: "RechargeCell")
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension RechargeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RechargeCell", for: indexPath) as! RechargeCell
        let product = products[indexPath.row]
        cell.configure(with: product)
        cell.selectionStyle = .none
        
        // 设置购买按钮点击事件
        cell.buyButtonTapHandler = { [weak self] in
            self?.handlePurchase(product)
        }
        
        return cell
    }
    
    private func handlePurchase(_ product: Product) {
        showLoading("加载商品信息...")
        
        StoreManager.shared.loadProducts(identifiers: [product.id]) { [weak self] products, error in
            
            if let error = error {
                self?.showError(error.localizedDescription)
                return
            }
            
            guard let storeProduct = products?.first else {
                self?.showError("未找到商品信息")
                return
            }
            
            // 发起购买
            self?.showLoading("购买中...")
            StoreManager.shared.purchase(product: storeProduct) { success, error in
                if success {                    
                    self?.showAlert(message: "充值成功!") {
                        // 刷新金币显示
                        if let user = User.loadFromKeychain() {
                            self?.coinsLabel.text = "当前金币：\(user.coins)"
                        }
                    }
                } else {
                    self?.showError(error?.localizedDescription ?? "购买失败")
                }
            }
        }
    }
} 
