import Foundation

struct Mood: Codable {
    let id: String
    let name: String
    let emoji: String
    let description: String
    
    static let allMoods: [Mood] = [
        Mood(id: "happy", name: "开心", emoji: "😊", description: "今天心情不错呢"),
        Mood(id: "excited", name: "兴奋", emoji: "🤩", description: "充满活力的一天"),
        Mood(id: "calm", name: "平静", emoji: "😌", description: "平和安宁的心情"),
        Mood(id: "tired", name: "疲惫", emoji: "😪", description: "需要休息一下"),
        Mood(id: "sad", name: "难过", emoji: "😢", description: "心情有点低落"),
        Mood(id: "angry", name: "生气", emoji: "😠", description: "让我冷静一下")
    ]
} 