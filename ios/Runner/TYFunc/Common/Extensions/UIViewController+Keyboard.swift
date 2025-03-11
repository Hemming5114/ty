import UIKit

extension UIViewController {
    func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            handleKeyboardShow(height: keyboardFrame.height)
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        handleKeyboardHide()
    }
    
    // 子类重写这些方法来处理键盘事件
    func handleKeyboardShow(height: CGFloat) {}
    func handleKeyboardHide() {}
} 