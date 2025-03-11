import Foundation

struct FortuneCache: Codable {
    let content: String
    let createdAt: Date
    
    var isValid: Bool {
        let calendar = Calendar.current
        let now = Date()
        let components = calendar.dateComponents([.day], from: createdAt, to: now)
        return components.day == 0 // 同一天内有效
    }
}

struct WeeklyFortuneCache: Codable {
    let content: String
    let createdAt: Date
    let weekOfYear: Int
    
    var isValid: Bool {
        let calendar = Calendar.current
        let now = Date()
        return calendar.component(.weekOfYear, from: createdAt) == calendar.component(.weekOfYear, from: now)
    }
}

struct MonthlyFortuneCache: Codable {
    let content: String
    let createdAt: Date
    let month: Int
    
    var isValid: Bool {
        let calendar = Calendar.current
        let now = Date()
        return calendar.component(.month, from: createdAt) == calendar.component(.month, from: now)
    }
} 