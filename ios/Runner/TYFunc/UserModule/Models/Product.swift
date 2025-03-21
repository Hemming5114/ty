struct Product: Codable {
    let id: String
    let name: String
    let price: Double
    let coins: Int?
    let duration: Int? // 会员时长(天)
    let isMember: Bool // 原来的 isVIP
    let isFirstTime: Bool // 是否首充优惠
    
    static let coinProducts = [

        Product(id: "com.funny2025.yu60", name: "60金币", price: 6, coins: 60, duration: nil, isMember: false, isFirstTime: false),
        Product(id: "com.funny2025.yu300", name: "300金币", price: 28, coins: 300, duration: nil, isMember: false, isFirstTime: false),
        Product(id: "com.funny2025.yu1130", name: "1130金币", price: 98, coins: 1130, duration: nil, isMember: false, isFirstTime: false),
        Product(id: "com.funny2025.yu2350", name: "2350金币", price: 198, coins: 2350, duration: nil, isMember: false, isFirstTime: false),
        Product(id: "com.funny2025.yu3070", name: "3070金币", price: 268, coins: 3070, duration: nil, isMember: false, isFirstTime: false),
        Product(id: "com.funny2025.yu3600", name: "3600金币", price: 298, coins: 3600, duration: nil, isMember: false, isFirstTime: false)
    ]
    
    static func memberProducts(isFirstTime: Bool) -> [Product] {
        if isFirstTime {
            return [
                Product(id: "com.funny2025.yu0", name: "首充特惠月卡", price: 88, coins: nil, duration: 30, isMember: true, isFirstTime: true),
                Product(id: "com.funny2025.yu2", name: "季度会员", price: 268, coins: nil, duration: 90, isMember: true, isFirstTime: false)
            ]
        } else {
            return [
                Product(id: "com.funny2025.yu1", name: "月度会员", price: 98, coins: nil, duration: 30, isMember: true, isFirstTime: false),
                Product(id: "com.funny2025.yu2", name: "季度会员", price: 268, coins: nil, duration: 90, isMember: true, isFirstTime: false)
            ]
        }
    }
} 
