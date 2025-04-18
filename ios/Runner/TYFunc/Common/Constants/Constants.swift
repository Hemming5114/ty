import UIKit

struct TYConstants {
    // MARK: - UI Constants
    struct UI {
        static let themeColor = UIColor(red: 171/255, green: 126/255, blue: 237/255, alpha: 1.0) // #AB7EED
        static let mainCornerRadius: CGFloat = 12.0
        
        struct Padding {
            static let small: CGFloat = 8
            static let normal: CGFloat = 16
            static let large: CGFloat = 20
            static let extraLarge: CGFloat = 30
        }
        
        struct Button {
            static let height: CGFloat = 50
            static let disabledColor = themeColor.withAlphaComponent(0.3)
        }
        
        struct Font {
            static let title = UIFont.systemFont(ofSize: 20, weight: .medium)
            static let subtitle = UIFont.systemFont(ofSize: 16, weight: .regular)
            static let body = UIFont.systemFont(ofSize: 14, weight: .regular)
            static let caption = UIFont.systemFont(ofSize: 12, weight: .regular)
        }
        
        struct Animation {
            static let duration: TimeInterval = 0.6
            static let shakeValues = [-12.0, 12.0, -8.0, 8.0, -4.0, 4.0, 0.0]
            
            struct Emoji {
                static let pulseScale: CGFloat = 1.1
                static let pulseDuration: TimeInterval = 1.0
                
                static let rotationAngle: CGFloat = 0.1
                static let rotationDuration: TimeInterval = 2.0
                
                static let bounceHeight: CGFloat = 8
                static let bounceDuration: TimeInterval = 0.8
                
                static let shakeOffset: CGFloat = 2
                static let shakeDuration: TimeInterval = 2.0
                
                static let selectScale: CGFloat = 1.3
                static let selectDuration: TimeInterval = 0.4
            }
        }
    }
    
    // MARK: - UserDefaults Keys
    struct UserDefaults {
        static let hasLaunched = "hasLaunched"
        static let hasMoodSelectedToday = "hasMoodSelectedToday"
        static let lastSelectedMood = "lastSelectedMood"
        static let lastMoodSelectionDate = "lastMoodSelectionDate"
        static let lastLoginDate = "lastLoginDate"
        static let appLaunchCount = "appLaunchCount"
    }
    
    // MARK: - API Constants
    struct API {
        static let baseURL = "https://api.example.com"
        static let timeout: TimeInterval = 30
        static let version = "v1"
    }
    
    // MARK: - Notification Names
    struct NotificationNames {
        static let userDidLogin = Notification.Name("userDidLogin")
        static let userDidLogout = Notification.Name("userDidLogout")
        static let moodDidSelect = Notification.Name("moodDidSelect")
        static let coinsDidUpdate = Notification.Name("coinsDidUpdate")
    }
    
    // MARK: - Error Messages
    struct ErrorMessage {
        static let networkError = "网络连接失败，请检查网络设置"
        static let serverError = "服务器异常，请稍后重试"
        static let unknownError = "未知错误，请重试"
    }
    
    // MARK: - Web URLs
    struct WebURL {
        static let userAgreement = "https://sites.google.com/view/ty20251/agreement" // TODO: 替换为实际的用户协议URL
        static let privacyPolicy = "https://sites.google.com/view/ty20252/privacy" // TODO: 替换为实际的隐私政策URL
    }
} 
