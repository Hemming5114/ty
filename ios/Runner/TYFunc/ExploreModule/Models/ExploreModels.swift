// 探索区块类型
enum ExploreSectionType {
    case explore  // 探索
    
    var title: String {
        switch self {
        case .explore: return "探索"
        }
    }
}

// 探索区块
struct ExploreSection {
    let type: ExploreSectionType
    let items: [Any]
}

// 探索项
struct ExploreItem {
    let title: String
    let description: String
}

// 运势项
struct FortuneItem {
    let title: String
    let description: String
}

// 秘境项
struct SecretItem {
    let title: String
    let description: String
    let image: String
} 