import UIKit
import SnapKit

class ExploreHeaderView: UICollectionReusableView {
    private let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        titleLabel.font = .systemFont(ofSize: 20, weight: .bold)
        titleLabel.textColor = TYConstants.UI.themeColor
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
        }
    }
    
    func configure(with title: String) {
        titleLabel.text = title
    }
} 