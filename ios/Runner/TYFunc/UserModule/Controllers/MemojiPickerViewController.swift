import UIKit
import SnapKit

class MemojiPickerViewController: UIViewController {
    private let collectionView: UICollectionView
    private let completion: (UIImage) -> Void
    
    // 使用预设的头像
    private let avatars = (1...10).map { "head_\($0)" }
    
    init(completion: @escaping (UIImage) -> Void) {
        self.completion = completion
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        title = "选择头像"
        view.backgroundColor = .systemGroupedBackground
        
        // 添加关闭按钮
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "取消",
            style: .plain,
            target: self,
            action: #selector(cancelTapped)
        )
        
        // 设置集合视图
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MemojiCell.self, forCellWithReuseIdentifier: "MemojiCell")
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    @objc private func cancelTapped() {
        dismiss(animated: true)
    }
}

// MARK: - UICollectionViewDelegate & DataSource
extension MemojiPickerViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return avatars.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemojiCell", for: indexPath) as! MemojiCell
        if let image = UIImage(named: avatars[indexPath.item]) {
            cell.configure(with: image)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = floor((collectionView.bounds.width - 64) / 3.0)
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let avatarName = avatars[indexPath.item]
        if let image = UIImage(named: avatarName) {
            // 设置图片标识符，用于保存
            image.accessibilityIdentifier = avatarName
            completion(image)
            dismiss(animated: true)
        }
    }
} 
