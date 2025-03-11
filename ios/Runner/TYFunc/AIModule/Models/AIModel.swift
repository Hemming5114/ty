import Foundation

struct AIModel: Codable {
    let id: String
    let name: String
    let description: String
    let personality: String
    let tags: [String]
    let openingMessage: String
    let features: [String]  // AI的特色功能
    let specialties: [String]  // AI的专长领域
    let style: String  // AI的对话风格
    let background: String  // AI的背景故事
    let totalChats: Int  // 总对话次数
    let rating: Double  // 评分
    
    // 获取头像图片名称
    var avatarImageName: String {
        return id
    }
}

struct AIMoodGroup: Codable {
    let mood: String
    let models: [AIModel]
} 