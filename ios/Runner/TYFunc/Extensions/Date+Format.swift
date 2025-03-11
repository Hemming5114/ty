import Foundation

extension Date {
    func chatTimeString() -> String {
        let calendar = Calendar.current
        let now = Date()
        let components = calendar.dateComponents([.day, .weekOfYear], from: self, to: now)
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "zh_CN")
        
        // 今天
        if calendar.isDateInToday(self) {
            formatter.dateFormat = "HH:mm"
            return formatter.string(from: self)
        }
        
        // 昨天
        if calendar.isDateInYesterday(self) {
            formatter.dateFormat = "'昨天' HH:mm"
            return formatter.string(from: self)
        }
        
        // 前天
        if let days = components.day, days == 2 {
            formatter.dateFormat = "'前天' HH:mm"
            return formatter.string(from: self)
        }
        
        // 本周
        if let weeks = components.weekOfYear, weeks == 0 {
            formatter.dateFormat = "EEEE HH:mm"
            return formatter.string(from: self)
        }
        
        // 本月
        if calendar.isDate(self, equalTo: now, toGranularity: .month) {
            formatter.dateFormat = "MM-dd HH:mm"
            return formatter.string(from: self)
        }
        
        // 其他时间
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        return formatter.string(from: self)
    }
} 