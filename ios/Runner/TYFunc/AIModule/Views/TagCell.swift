import UIKit

class TagCell: UICollectionViewCell {
    private let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.backgroundColor = TYConstants.UI.themeColor.withAlphaComponent(0.1)
        contentView.layer.cornerRadius = 16
        
        label.font = TYConstants.UI.Font.caption
        label.textColor = TYConstants.UI.themeColor
        label.textAlignment = .center
        
        contentView.addSubview(label)
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 6, left: 12, bottom: 6, right: 12))
        }
    }
    
    func configure(with text: String) {
        label.text = text
    }
} 