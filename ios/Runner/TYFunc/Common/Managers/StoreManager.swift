import StoreKit

class StoreManager: NSObject {
    static let shared = StoreManager()
    
    // 通知名称
    static let purchaseSuccessNotification = Notification.Name("PurchaseSuccessNotification")
    static let purchaseFailureNotification = Notification.Name("PurchaseFailureNotification")
    
    private var products: [SKProduct] = []
    private var purchaseCompletion: ((Bool, Error?) -> Void)?
    private var productsCompletion: (([SKProduct]?, Error?) -> Void)?
    
    private override init() {
        super.init()
        // 设置交易观察者
        SKPaymentQueue.default().add(self)
    }
    
    deinit {
        SKPaymentQueue.default().remove(self)
    }
    
    // 加载商品信息
    func loadProducts(identifiers: [String], completion: @escaping ([SKProduct]?, Error?) -> Void) {
        self.productsCompletion = completion
        
        let request = SKProductsRequest(productIdentifiers: Set(identifiers))
        request.delegate = self
        request.start()
    }
    
    // 购买商品
    func purchase(product: SKProduct, completion: @escaping (Bool, Error?) -> Void) {
        guard SKPaymentQueue.canMakePayments() else {
            completion(false, NSError(domain: "StoreManager", code: -1, userInfo: [NSLocalizedDescriptionKey: "不能进行支付"]))
            return
        }
        
        self.purchaseCompletion = completion
        let payment = SKPayment(product: product)
        SKPaymentQueue.default().add(payment)
    }
    
    // 恢复购买
    func restorePurchases(completion: @escaping (Bool, Error?) -> Void) {
        self.purchaseCompletion = completion
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
}

// MARK: - SKProductsRequestDelegate
extension StoreManager: SKProductsRequestDelegate {
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        DispatchQueue.main.async { [weak self] in
            self?.productsCompletion?(response.products, nil)
            self?.productsCompletion = nil
        }
    }
    
    func request(_ request: SKRequest, didFailWithError error: Error) {
        DispatchQueue.main.async { [weak self] in
            self?.productsCompletion?(nil, error)
            self?.productsCompletion = nil
        }
    }
}

// MARK: - SKPaymentTransactionObserver
extension StoreManager: SKPaymentTransactionObserver {
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState {
            case .purchased:
                handlePurchaseSuccess(transaction: transaction)
                
            case .failed:
                handlePurchaseFailure(transaction: transaction)
                
            case .restored:
                handlePurchaseSuccess(transaction: transaction)
                
            case .deferred:
                break
                
            case .purchasing:
                break
                
            @unknown default:
                break
            }
        }
    }
    
    private func handlePurchaseSuccess(transaction: SKPaymentTransaction) {
        guard let productId = transaction.payment.productIdentifier.components(separatedBy: ".").last else {
            return
        }
        
        // 获取用户
        guard var user = User.loadFromKeychain() else { return }
        
        // 根据商品ID处理不同类型的购买
        if let product = Product.coinProducts.first(where: { $0.id == productId }) {
            // 充值金币
            user.coins += product.coins ?? 0
            // 使用现有的通知名称
            
        } else if let product = Product.memberProducts(isFirstTime: !user.hasEverBeenMember).first(where: { $0.id == productId }) {
            // 开通会员
            user.isMember = true
            user.hasEverBeenMember = true
            if let duration = product.duration {
                let expiryDate = user.memberExpiryDate ?? Date()
                user.memberExpiryDate = Calendar.current.date(byAdding: .day, value: duration, to: expiryDate)
            }
        }
        
        // 保存用户信息
        try? user.saveToKeychain()
        
        // 完成交易
        SKPaymentQueue.default().finishTransaction(transaction)
        
        // 发送购买成功通知
        NotificationCenter.default.post(name: NSNotification.Name("UserCoinsDidChangeNotification"), object: nil)
        
        DispatchQueue.main.async { [weak self] in
            self?.purchaseCompletion?(true, nil)
            self?.purchaseCompletion = nil
        }
    }
    
    private func handlePurchaseFailure(transaction: SKPaymentTransaction) {
        SKPaymentQueue.default().finishTransaction(transaction)
        
        DispatchQueue.main.async { [weak self] in
            self?.purchaseCompletion?(false, transaction.error)
            self?.purchaseCompletion = nil
        }
    }
    
    func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
        DispatchQueue.main.async { [weak self] in
            self?.purchaseCompletion?(true, nil)
            self?.purchaseCompletion = nil
        }
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, restoreCompletedTransactionsFailedWithError error: Error) {
        DispatchQueue.main.async { [weak self] in
            self?.purchaseCompletion?(false, error)
            self?.purchaseCompletion = nil
        }
    }
} 
