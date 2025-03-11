import UIKit

class TagListView: UIView {
    private var tags: [UILabel] = []
    
    var alignment: TagAlignment = .left
    var tagBackgroundColor: UIColor = .systemGray6
    var textColor: UIColor = .label
    var cornerRadius: CGFloat = 12
    var paddingX: CGFloat = 12
    var paddingY: CGFloat = 8
    var marginX: CGFloat = 8
    var marginY: CGFloat = 8
    
    enum TagAlignment {
        case left
        case center
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        var currentX: CGFloat = 0
        var currentY: CGFloat = 0
        var rowHeight: CGFloat = 0
        var rowTags: [UILabel] = []
        
        // 第一遍遍历计算位置
        for tag in tags {
            let tagSize = tag.sizeThatFits(bounds.size)
            let tagWidth = tagSize.width + (paddingX * 2)
            
            if currentX + tagWidth > bounds.width {
                // 需要换行
                alignRow(rowTags, y: currentY)
                currentX = 0
                currentY += rowHeight + marginY
                rowHeight = 0
                rowTags.removeAll()
            }
            
            tag.frame = CGRect(
                x: currentX,
                y: currentY,
                width: tagWidth,
                height: tagSize.height + (paddingY * 2)
            )
            
            currentX += tagWidth + marginX
            rowHeight = max(rowHeight, tagSize.height + (paddingY * 2))
            rowTags.append(tag)
        }
        
        // 处理最后一行
        if !rowTags.isEmpty {
            alignRow(rowTags, y: currentY)
        }
        
        // 更新视图高度
        let height = currentY + rowHeight
        if let heightConstraint = constraints.first(where: { $0.firstAttribute == .height }) {
            heightConstraint.constant = height
        } else {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
    private func alignRow(_ rowTags: [UILabel], y: CGFloat) {
        guard !rowTags.isEmpty else { return }
        
        let rowWidth = rowTags.reduce(0) { $0 + $1.frame.width } + CGFloat(rowTags.count - 1) * marginX
        
        if alignment == .center && rowWidth < bounds.width {
            let offset = (bounds.width - rowWidth) / 2
            for tag in rowTags {
                tag.frame.origin.x += offset
            }
        }
    }
    
    func addTag(_ text: String) {
        let label = UILabel()
        label.text = text
        label.textColor = textColor
        label.font = TYConstants.UI.Font.body
        label.backgroundColor = tagBackgroundColor
        label.textAlignment = .center
        label.layer.cornerRadius = cornerRadius
        label.layer.masksToBounds = true
        
        addSubview(label)
        tags.append(label)
        
        setNeedsLayout()
    }
    
    func removeAllTags() {
        tags.forEach { $0.removeFromSuperview() }
        tags.removeAll()
        setNeedsLayout()
    }
} 