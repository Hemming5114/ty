import Foundation

class FortuneService {
    static let shared = FortuneService()
    private let defaults = UserDefaults.standard
    
    private let dailyKey = "daily_fortune"
    private let weeklyKey = "weekly_fortune"
    private let monthlyKey = "monthly_fortune"
    
    private init() {}
    
    func getDailyFortune(completion: @escaping (Result<String, Error>) -> Void) {
        if let cached = loadDailyCache(), cached.isValid {
            completion(.success(cached.content))
            return
        }
        
        generateFortune(type: "daily") { [weak self] result in
            switch result {
            case .success(let content):
                self?.saveDailyCache(content: content)
                completion(.success(content))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getWeeklyFortune(completion: @escaping (Result<String, Error>) -> Void) {
        if let cached = loadWeeklyCache(), cached.isValid {
            completion(.success(cached.content))
            return
        }
        
        generateFortune(type: "weekly") { [weak self] result in
            switch result {
            case .success(let content):
                self?.saveWeeklyCache(content: content)
                completion(.success(content))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getMonthlyFortune(completion: @escaping (Result<String, Error>) -> Void) {
        if let cached = loadMonthlyCache(), cached.isValid {
            completion(.success(cached.content))
            return
        }
        
        generateFortune(type: "monthly") { [weak self] result in
            switch result {
            case .success(let content):
                self?.saveMonthlyCache(content: content)
                completion(.success(content))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    public func generateFortune(type: String, completion: @escaping (Result<String, Error>) -> Void) {
        let prompt: String
        switch type {
        case "daily":
            prompt = "请生成一段100-400字的今天桃运缘分内容，要积极向上、富有希望"
        case "weekly":
            prompt = "请生成一段100-400字的本周桃运美好内容，要积极向上、富有希望"
        case "monthly":
            prompt = "请生成一段100-400字的本月桃运命中注定内容，要积极向上、富有希望"
        default:
            prompt = "请生成一段探索内容"
        }
        
        ZhipuAIService.shared.sendMessage(prompt) { result in
            completion(result)
        }
    }
    
    // MARK: - Cache Operations
    private func loadDailyCache() -> FortuneCache? {
        guard let data = defaults.data(forKey: dailyKey),
              let cache = try? JSONDecoder().decode(FortuneCache.self, from: data)
        else { return nil }
        
        // 判断是否是当天
        let calendar = Calendar.current
        let now = Date()
        if !calendar.isDate(cache.createdAt, inSameDayAs: now) {
            return nil
        }
        return cache
    }
    
    private func saveDailyCache(content: String) {
        let cache = FortuneCache(content: content, createdAt: Date())
        if let data = try? JSONEncoder().encode(cache) {
            defaults.set(data, forKey: dailyKey)
        }
    }
    
    private func loadWeeklyCache() -> WeeklyFortuneCache? {
        guard let data = defaults.data(forKey: weeklyKey),
              let cache = try? JSONDecoder().decode(WeeklyFortuneCache.self, from: data)
        else { return nil }
        
        // 判断是否是当周
        let calendar = Calendar.current
        let now = Date()
        let cacheWeek = calendar.component(.weekOfYear, from: cache.createdAt)
        let currentWeek = calendar.component(.weekOfYear, from: now)
        
        if cacheWeek != currentWeek {
            return nil
        }
        return cache
    }
    
    private func saveWeeklyCache(content: String) {
        let cache = WeeklyFortuneCache(
            content: content,
            createdAt: Date(),
            weekOfYear: Calendar.current.component(.weekOfYear, from: Date())
        )
        if let data = try? JSONEncoder().encode(cache) {
            defaults.set(data, forKey: weeklyKey)
        }
    }
    
    private func loadMonthlyCache() -> MonthlyFortuneCache? {
        guard let data = defaults.data(forKey: monthlyKey),
              let cache = try? JSONDecoder().decode(MonthlyFortuneCache.self, from: data)
        else { return nil }
        
        // 判断是否是当月
        let calendar = Calendar.current
        let now = Date()
        let cacheMonth = calendar.component(.month, from: cache.createdAt)
        let currentMonth = calendar.component(.month, from: now)
        
        if cacheMonth != currentMonth {
            return nil
        }
        return cache
    }
    
    private func saveMonthlyCache(content: String) {
        let cache = MonthlyFortuneCache(
            content: content,
            createdAt: Date(),
            month: Calendar.current.component(.month, from: Date())
        )
        if let data = try? JSONEncoder().encode(cache) {
            defaults.set(data, forKey: monthlyKey)
        }
    }
} 
