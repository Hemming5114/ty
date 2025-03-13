class MemberViewController: UIViewController {
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    private var products: [Product] = []
    private let headerView = UIView()
    private let statusLabel = UILabel()
    private let expiryLabel = UILabel()
    
    // 会员权益数据
    private let memberBenefits = [
        MemberBenefit(icon: "infinity", title: "无限对话", description: "与AI助手无限次数对话"),
        MemberBenefit(icon: "wand.and.stars", title: "专属AI", description: "解锁更多性格特征的AI助手"),
        MemberBenefit(icon: "chart.line.uptrend.xyaxis", title: "深度分析", description: "获取详细的情绪分析报告"),
        MemberBenefit(icon: "music.note", title: "音乐特权", description: "解锁所有背景音乐"),
        MemberBenefit(icon: "crown.fill", title: "尊贵标识", description: "专属会员标识"),
        MemberBenefit(icon: "bell.badge.fill", title: "优先响应", description: "获得优先的服务支持")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadProducts { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    private func setupUI() {
        title = "开通会员"
        view.backgroundColor = .systemGroupedBackground
        
        // 设置头部视图
        headerView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 80)
        headerView.backgroundColor = .clear
        
        statusLabel.font = .systemFont(ofSize: 24, weight: .medium)
        statusLabel.textColor = TYConstants.UI.themeColor
        statusLabel.textAlignment = .center
        
        expiryLabel.font = .systemFont(ofSize: 16)
        expiryLabel.textColor = .systemGray
        expiryLabel.textAlignment = .center
        
        updateMemberStatus()
        
        headerView.addSubview(statusLabel)
        headerView.addSubview(expiryLabel)
        
        statusLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(20)
        }
        
        expiryLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(statusLabel.snp.bottom).offset(12)
        }
        
        tableView.tableHeaderView = headerView
        tableView.register(MemberCell.self, forCellReuseIdentifier: "MemberCell")
        tableView.register(MemberBenefitCell.self, forCellReuseIdentifier: "MemberBenefitCell")
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func updateMemberStatus() {
        if let user = User.loadFromKeychain() {
            statusLabel.text = user.isMember ? "会员用户" : "普通用户"
            if let expiryDate = user.memberExpiryDate {
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd"
                expiryLabel.text = "到期时间：\(formatter.string(from: expiryDate))"
            } else {
                expiryLabel.text = "尚未开通会员"
            }
        }
    }
    
    private func loadProducts(completion: @escaping () -> Void) {
        showLoading("加载商品信息...")
        
        // 模拟网络请求延迟
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.hideLoading()
            
            if let user = User.loadFromKeychain() {
                self?.products = Product.memberProducts(isFirstTime: !user.hasEverBeenMember)
                completion()
            }
        }
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
                    self?.showAlert( message: "开通成功!") {
                        // 刷新会员状态
                        self?.updateMemberStatus()
                        // 重新加载商品列表（可能需要更新首充状态）
                        self?.loadProducts { [weak self] in
                            self?.tableView.reloadData()
                        }
                    }
                } else {
                    self?.showError(error?.localizedDescription ?? "购买失败")
                }
            }
        }
    }
}

// MARK: - UITableViewDelegate & DataSource
extension MemberViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2 // 会员套餐和会员权益两个section
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? products.count : memberBenefits.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "会员套餐" : "会员权益"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MemberCell", for: indexPath) as! MemberCell
            let product = products[indexPath.row]
            cell.configure(with: product)
            cell.selectionStyle = .none
            
            // 设置购买按钮点击事件
            cell.buyButtonTapHandler = { [weak self] in
                self?.handlePurchase(product)
            }
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MemberBenefitCell", for: indexPath) as! MemberBenefitCell
            let benefit = memberBenefits[indexPath.row]
            cell.configure(with: benefit)
            cell.selectionStyle = .none
            return cell
        }
    }
}


