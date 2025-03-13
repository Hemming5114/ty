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
    
    // 生成每日运势
    func generateDailyFortune(completion: @escaping (String) -> Void) {
        if let cache = loadDailyCache(), cache.isValid {
            completion(cache.content)
            return
        }
        
        guard let user = User.loadFromKeychain() else {
            completion("今天运势平平，宜静心修养")
            return
        }
        
        // 根据用户名生成运势
        let prompt = """
        你是一位专业的占卜师，请根据用户"\(user.name)"的名字为其生成今日运势，包含以下内容：
        1. 今日运势评分（1-5星）
        2. 一句积极正面的运势描述（20字以内）
        3. 今日宜忌（各2项）
        请用简洁的格式输出。
        """
        
        ZhipuAIService.shared.sendMessage(prompt) { [weak self] result in
            switch result {
            case .success(let content):
                // 缓存运势
                let cache = FortuneCache(content: content, createdAt: Date())
                self?.saveDailyCache(content: content)
                completion(content)
                
            case .failure:
                // 生成失败时返回默认运势
                let defaultFortune = """
                今日运势：★★★☆☆
                运势描述：心怀感恩，好运自来
                宜：学习充电、与朋友聚会
                忌：过度劳累、轻信他人
                """
                completion(defaultFortune)
            }
        }
    }
    
    // 生成月度运势
    func generateMonthlyFortune(completion: @escaping (String) -> Void) {
        if let cache = loadMonthlyCache(), cache.isValid {
            completion(cache.content)
            return
        }
        
        guard let user = User.loadFromKeychain() else {
            completion("本月运势平稳，保持平常心")
            return
        }
        
        // 根据用户名生成月度运势
        let prompt = """
        你是一位专业的占卜师，请根据用户"\(user.name)"的名字为其生成本月运势，包含以下内容：
        1. 本月运势评分（1-5星）
        2. 月度运势概述（40字以内）
        3. 本月重点关注领域（3项）
        4. 开运建议（2项）
        请用简洁的格式输出。
        """
        
        ZhipuAIService.shared.sendMessage(prompt) { [weak self] result in
            switch result {
            case .success(let content):
                // 缓存运势
                let cache = FortuneCache(content: content, createdAt: Date())
                self?.saveMonthlyCache(content: content)
                completion(content)
                
            case .failure:
                // 生成失败时返回默认运势
                let defaultFortune = """
                本月运势：★★★★☆
                运势概述：诸事顺遂，保持积极心态，好运将至
                重点关注：
                1. 自我提升
                2. 人际关系
                3. 健康管理
                开运建议：
                1. 多与亲朋好友互动交流
                2. 保持规律作息，注意运动
                """
                completion(defaultFortune)
            }
        }
    }
    
    // 生成周运势
    func generateWeeklyFortune(completion: @escaping (String) -> Void) {
        if let cache = loadWeeklyCache(), cache.isValid {
            completion(cache.content)
            return
        }
        
        guard let user = User.loadFromKeychain() else {
            completion("本周运势平稳，继续加油")
            return
        }
        
        // 根据用户名生成周运势
        let prompt = """
        你是一位专业的占卜师，请根据用户"\(user.name)"的名字为其生成本周运势，包含以下内容：
        1. 本周运势评分（1-5星）
        2. 周运势概述（30字以内）
        3. 本周吉日（2天）
        4. 开运建议（2项）
        请用简洁的格式输出。
        """
        
        ZhipuAIService.shared.sendMessage(prompt) { [weak self] result in
            switch result {
            case .success(let content):
                // 缓存运势
                self?.saveWeeklyCache(content: content)
                completion(content)
                
            case .failure:
                // 生成失败时返回默认运势
                let defaultFortune = """
                本周运势：★★★★☆
                运势概述：贵人相助，事业有成
                吉日：周三、周六
                开运建议：
                1. 把握贵人机会，主动社交
                2. 适当运动，保持活力
                """
                completion(defaultFortune)
            }
        }
    }
} 
