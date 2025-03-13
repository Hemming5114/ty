import UIKit
import ProgressHUD

extension UIViewController {
    func showAlert(message: String?, completion: (() -> Void)? = nil) {
        ProgressHUD.colorAnimation = TYConstants.UI.themeColor
        ProgressHUD.succeed(message, interaction: false, delay: 2)
        
        if let completion = completion {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                completion()
            }
        }
    }
    
    func showConfirmAlert(title: String?, message: String?, confirmTitle: String = "确定", cancelTitle: String = "取消", confirmHandler: @escaping () -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: cancelTitle, style: .cancel))
        alert.addAction(UIAlertAction(title: confirmTitle, style: .default) { _ in
            confirmHandler()
        })
        
        present(alert, animated: true)
    }
    
    func showLoading(_ message: String? = nil) {
        ProgressHUD.colorAnimation = TYConstants.UI.themeColor
        ProgressHUD.animate(message, interaction: false)
    }
    
    func hideLoading() {
        ProgressHUD.dismiss()
    }
    
    func showError(_ message: String) {
        ProgressHUD.colorAnimation = TYConstants.UI.themeColor
        ProgressHUD.failed(message, interaction: false, delay: 2)
    }
} 
