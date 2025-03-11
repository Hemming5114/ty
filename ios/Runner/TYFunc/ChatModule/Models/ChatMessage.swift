import Foundation

enum MessageType: String, Codable {
    case text
    case system
}

enum MessageRole: String, Codable {
    case user
    case assistant
    case system
}

struct ChatMessage: Codable {
    let id: String
    let content: String
    let type: MessageType
    let role: MessageRole
    let timestamp: Date
    
    init(id: String = UUID().uuidString,
         content: String,
         type: MessageType = .text,
         role: MessageRole,
         timestamp: Date = Date()) {
        self.id = id
        self.content = content
        self.type = type
        self.role = role
        self.timestamp = timestamp
    }
}

struct ChatSession: Codable {
    let id: String
    let aiModel: AIModel
    var messages: [ChatMessage]
    let createdAt: Date
    var lastMessageAt: Date
    
    init(id: String = UUID().uuidString,
         aiModel: AIModel,
         messages: [ChatMessage] = [],
         createdAt: Date = Date(),
         lastMessageAt: Date = Date()) {
        self.id = id
        self.aiModel = aiModel
        self.messages = messages
        self.createdAt = createdAt
        self.lastMessageAt = lastMessageAt
    }
} 