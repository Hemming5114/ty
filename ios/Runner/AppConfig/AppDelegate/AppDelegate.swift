//
//  AppDelegate.swift
//  AIRun
//
//  Created by AIRun on 20247/4.
//
import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
    
    /// 窗口
    var reachability: Reachability?
    override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        setupLaunchWindow()
        setupLocationService()
        addNetWorkReachabilityStatus(launchOptions: launchOptions)
        setupFireBase()
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    override func applicationDidBecomeActive(_ application: UIApplication) {
        
    }

    override func applicationWillResignActive(_ application: UIApplication) {
        let count = APPIMManager.share.unreadMsgNum
        application.applicationIconBadgeNumber = count
    }
    
    override func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        return true
    }
    
    override func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        return true
    }
    
    override func applicationWillTerminate(_ application: UIApplication) {
        
    }
    
    override func application(_ application: UIApplication, handleOpen url: URL) -> Bool {
        GIDSignIn.sharedInstance.handle(url)
        return true
    }
    
    override func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let deviceStr = deviceToken.map { String(format: "%02hhx", $0) }.joined()
         Messaging.messaging().apnsToken = deviceToken
         printLog(message: "APNS Token = \(deviceStr)")
         Messaging.messaging().token { token, error in
             if let error = error {
                 printLog(message: "error = \(error)")
             } else if let token = token {
                 printLog(message: "token = \(token)")
             }
         }
    }
    
    override func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("推送注册失败: \(error)")
    }
    
    // MARK:收到推送消息
    override func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        handleRemoteNotification(userInfo)
        
        completionHandler(.newData)
    }
    
    /// 点击消息（app运行中）
    override func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        // 处理业务跳转
        if UIApplication.shared.applicationState == .active {
           
        } else {
            
        }
        completionHandler()
    }
   
}

extension AppDelegate {
    private func setupLaunchWindow() {
        // 启动window
        
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        self.window.backgroundColor = .white
        self.window.makeKeyAndVisible()
        if let configModel = AppCacheManager.default.loadCurrentModelData(modelType: AppConfigModel.self, key: UserDefaults.configBasicData) {
            APPManager.default.config = configModel
            self.window.rootViewController = BaseTabBarController()
        }else{
            self.window.rootViewController = LaunchController()
        }
        APPManager.default.requestAppConfigData()
    }
    public func setupHomeWindow() {
        // 新建Window
        self.window.rootViewController = BaseTabBarController()
    }
   
}

