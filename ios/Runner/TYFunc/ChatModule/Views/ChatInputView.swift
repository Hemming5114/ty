import UIKit
import SnapKit

protocol ChatInputViewDelegate: AnyObject {
    func chatInputView(_ inputView: ChatInputView, didSendMessage text: String)
}

class ChatInputView: UIView {
    private let textView = UITextView()
    private let sendButton = UIButton()
    weak var delegate: ChatInputViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .clear
        
        layer.shadowColor = nil
        layer.shadowOpacity = 0
        layer.shadowOffset = .zero
        layer.shadowRadius = 0
        
        textView.font = TYConstants.UI.Font.body
        textView.textColor = .black
        textView.backgroundColor = .systemGray6
        textView.layer.cornerRadius = 18
        textView.textContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        textView.isScrollEnabled = false
        
        sendButton.setImage(UIImage(systemName: "arrow.up.circle.fill"), for: .normal)
        sendButton.tintColor = TYConstants.UI.themeColor
        sendButton.addTarget(self, action: #selector(sendTapped), for: .touchUpInside)
        
        addSubview(textView)
        addSubview(sendButton)
        
        textView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().offset(-8)
            make.trailing.equalTo(sendButton.snp.leading).offset(-8)
            make.height.lessThanOrEqualTo(100)
        }
        
        sendButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalTo(textView)
            make.width.height.equalTo(36)
        }
    }
    
    @objc private func sendTapped() {
        guard let text = textView.text?.trimmingCharacters(in: .whitespacesAndNewlines),
              !text.isEmpty else {
            return
        }
        
        delegate?.chatInputView(self, didSendMessage: text)
        textView.text = nil
    }
} 