import Foundation
import KeychainAccess

struct KeychainHelper {
    static let shared = KeychainHelper()
    
    // 修改 Keychain 配置，添加 accessGroup 和 synchronizable 选项
    private let keychain: Keychain = {
        let bundleId = Bundle.main.bundleIdentifier ?? "com.ty.app"
        let keychain = Keychain(service: bundleId)
            .accessibility(.afterFirstUnlock)
            .synchronizable(true)
        return keychain
    }()
    
    private init() {}
    
    // MARK: - Error
    enum KeychainError: Error {
        case saveError(Error)
        case loadError(Error)
        case dataNotFound
        case encodingError
        case decodingError
    }
    
    // MARK: - Generic Methods
    func save<T: Encodable>(_ item: T, forKey key: String) throws {
        do {
            let data = try JSONEncoder().encode(item)
            #if DEBUG
            print("Saving to Keychain - Key: \(key), Data: \(String(data: data, encoding: .utf8) ?? "nil")")
            #endif
            try keychain.set(data, key: key)
        } catch {
            #if DEBUG
            print("Failed to save to Keychain - Key: \(key), Error: \(error)")
            #endif
            throw KeychainError.saveError(error)
        }
    }
    
    func load<T: Decodable>(forKey key: String) throws -> T {
        do {
            guard let data = try keychain.getData(key) else {
                #if DEBUG
                print("No data found in Keychain for key: \(key)")
                #endif
                throw KeychainError.dataNotFound
            }
            
            #if DEBUG
            print("Loading from Keychain - Key: \(key), Data: \(String(data: data, encoding: .utf8) ?? "nil")")
            #endif
            
            return try JSONDecoder().decode(T.self, from: data)
        } catch let error as KeychainError {
            throw error
        } catch let error as DecodingError {
            #if DEBUG
            print("Decoding error for key \(key): \(error)")
            #endif
            throw KeychainError.decodingError
        } catch {
            #if DEBUG
            print("Failed to load from Keychain - Key: \(key), Error: \(error)")
            #endif
            throw KeychainError.loadError(error)
        }
    }
    
    func delete(forKey key: String) throws {
        try keychain.remove(key)
    }
    
    func clearAll() throws {
        try keychain.removeAll()
    }
} 