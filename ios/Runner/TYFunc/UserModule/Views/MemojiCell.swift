import UIKit
import SnapKit

class MemojiCell: UICollectionViewCell {
    private let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 12
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.1
        contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
        contentView.layer.shadowRadius = 4
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        contentView.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(12)
        }
    }
    
    func configure(with image: UIImage) {
        imageView.image = image
    }
    
    override var isSelected: Bool {
        didSet {
            UIView.animate(withDuration: 0.2) {
                self.transform = self.isSelected ? 
                    CGAffineTransform(scaleX: 0.9, y: 0.9) : .identity
            }
        }
    }
} 