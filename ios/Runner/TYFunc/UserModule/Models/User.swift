import Foundation

struct User: Codable {
    let id: String
    let name: String
    let avatar: String
    var coins: Int
    var isMember: Bool 
    var memberExpiryDate: Date?
    var hasEverBeenMember: Bool
    
    private static let keychainKey = "AppUserInfo0"
    
    static func generateNewUser(completion: @escaping (Result<User, Error>) -> Void) {
        let userId = String(format: "%06d", Int.random(in: 100000...999999))
        let randomAvatar = "head_\(Int.random(in: 1...10))"
        let coins = Int.random(in: 1000...9999) // 随机生成4位数金币
        
        // 调用智谱接口生成用户名
        ZhipuAIService.shared.sendMessage("帮我取一个2～6位的中文名字") { result in
            switch result {
            case .success(let response):
                // 清理可能的多余字符，只保留中文名字
                let name = response.trimmingCharacters(in: .whitespacesAndNewlines)
                    .components(separatedBy: CharacterSet.letters.union(.whitespaces).inverted)
                    .joined()
                    .prefix(6)
                    .trimmingCharacters(in: .whitespaces)
                
                // 如果获取到的名字不符合要求，使用默认名字
                let userName = name.count >= 2 ? name : "用户\(userId)"
                
                let user = User(
                    id: userId, 
                    name: String(userName), 
                    avatar: randomAvatar, 
                    coins: coins,
                    isMember: false,
                    memberExpiryDate: nil,
                    hasEverBeenMember: false
                )
                completion(.success(user))
                
            case .failure(let error):
                // 接口失败时使用默认名字
                completion(.failure(error))
            }
        }
    }
    
    func saveToKeychain() {
        do {
            try KeychainHelper.shared.save(self, forKey: User.keychainKey)
            #if DEBUG
            print("Successfully saved user to keychain: \(self)")
            #endif
        } catch {
            #if DEBUG
            print("Failed to save user to keychain: \(error)")
            #endif
        }
    }
    
    static func loadFromKeychain() -> User? {
        do {
            let user: User = try KeychainHelper.shared.load(forKey: keychainKey)
            #if DEBUG
            print("Successfully loaded user from keychain: \(user)")
            #endif
            return user
        } catch {
            #if DEBUG
            print("Failed to load user from keychain: \(error)")
            if case KeychainHelper.KeychainError.dataNotFound = error {
                print("No user data found in keychain")
            }
            #endif
            return nil
        }
    }
    
    // 检查是否需要消耗金币
    func needsCoinsForChat() -> Bool {
        return !isMember
    }
    
    // 消耗金币
    mutating func consumeCoins(_ amount: Int) -> Bool {
        if coins >= amount {
            coins -= amount
            saveToKeychain()
            return true
        }
        return false
    }
}

// MARK: - CustomStringConvertible
extension User: CustomStringConvertible {
    var description: String {
        return "User(id: \(id), name: \(name), avatar: \(avatar), coins: \(coins), isMember: \(isMember), memberExpiryDate: \(String(describing: memberExpiryDate)))"
    }
} 
