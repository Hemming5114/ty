import Foundation

class ChatManager {
    static let shared = ChatManager()
    private let defaults = UserDefaults.standard
    private let sessionsKey = "chatSessions"
    
    
    public var currentMood: String = "happy"

    private let blockAICacheKey = "blockAICacheKey"

    public var blockSet = Set<String>()


    
    private init() {
        
        if let array = defaults.array(forKey: blockAICacheKey) as? [String] {
            blockSet = Set(array)
        }
    }

    // 获取所有会话
    func getAllSessions() -> [ChatSession] {
        guard let data = defaults.data(forKey: sessionsKey),
              let sessions = try? JSONDecoder().decode([ChatSession].self, from: data) else {
            return []
        }
        return sessions.sorted { $0.lastMessageAt > $1.lastMessageAt }
    }
    
    // 获取单个会话
    func getSession(id: String) -> ChatSession? {
        return getAllSessions().first { $0.id == id }
    }
    
    // 保存会话
    func saveSession(_ session: ChatSession) {
        var sessions = getAllSessions()
        if let index = sessions.firstIndex(where: { $0.id == session.id }) {
            sessions[index] = session
        } else {
            sessions.append(session)
        }
        
        if let data = try? JSONEncoder().encode(sessions) {
            defaults.set(data, forKey: sessionsKey)
        }
    }
    
    // 删除会话
    func deleteSession(id: String) {
        var sessions = getAllSessions()
        sessions.removeAll { $0.id == id }
        
        if let data = try? JSONEncoder().encode(sessions) {
            defaults.set(data, forKey: sessionsKey)
        }
    }
    
    // 获取AI开场白
    func getOpeningMessage(for ai: AIModel) -> String {
        return ai.openingMessage
    }
    
    func saveSessions(_ sessions: [ChatSession]) {
        // 保存所有会话
        UserDefaults.standard.set(try? JSONEncoder().encode(sessions), forKey: "chatSessions")
        UserDefaults.standard.synchronize()
    }
    
    func deleteSession(_ session: ChatSession) {
        var sessions = getAllSessions()
        sessions.removeAll { $0.id == session.id }
        saveSessions(sessions)
    }
    
    func deleteAllSessions() {
        saveSessions([])
    }
    
    func addBlockSession(_ AiID: String) {
        blockSet.insert(AiID)
        let temArray = Array(blockSet)
        defaults.set(temArray, forKey: blockAICacheKey)
    }
    
    // 删除会话
    func removeBlockSession(_ AiID: String) {
        blockSet.remove(AiID)
        let temArray = Array(blockSet)
        defaults.set(temArray, forKey: blockAICacheKey)
    }

}
