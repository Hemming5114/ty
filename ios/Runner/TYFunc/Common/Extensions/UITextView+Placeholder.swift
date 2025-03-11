import UIKit

extension UITextView {
    private struct AssociatedKeys {
        static var placeholder = "placeholder"
        static var placeholderColor = "placeholderColor"
    }
    
    @IBInspectable
    var placeholder: String? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.placeholder) as? String
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.placeholder, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
            if text.isEmpty {
                text = newValue
                textColor = placeholderColor
            }
            
            NotificationCenter.default.addObserver(self, selector: #selector(textDidBeginEditing), name: UITextView.textDidBeginEditingNotification, object: self)
            NotificationCenter.default.addObserver(self, selector: #selector(textDidEndEditing), name: UITextView.textDidEndEditingNotification, object: self)
        }
    }
    
    @IBInspectable
    var placeholderColor: UIColor {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.placeholderColor) as? UIColor ?? .lightGray
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.placeholderColor, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            if text == placeholder {
                textColor = newValue
            }
        }
    }
    
    @objc private func textDidBeginEditing() {
        if text == placeholder {
            text = ""
            textColor = .darkGray
        }
    }
    
    @objc private func textDidEndEditing() {
        if text.isEmpty {
            text = placeholder
            textColor = placeholderColor
        }
    }
} 