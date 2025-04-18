import UIKit
import SnapKit
import PhotosUI

class FeedbackViewController: UIViewController {
    // MARK: - UI Components
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let feedbackTextView: UITextView = {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 16)
        textView.textColor = .black
        textView.backgroundColor = .white
        textView.layer.cornerRadius = 12
        textView.textContainerInset = UIEdgeInsets(top: 12, left: 8, bottom: 12, right: 8)
        return textView
    }()
    
    private let placeholderLabel: UILabel = {
        let label = UILabel()
        label.text = "请描述你遇到的问题或建议..."
        label.font = .systemFont(ofSize: 16)
        label.textColor = .systemGray3
        return label
    }()
    
    private let imageCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 12
        layout.itemSize = CGSize(width: 80, height: 80)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    private let contactTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 12
        textField.placeholder = "请输入邮箱或手机号码"
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 44))
        textField.leftViewMode = .always
        textField.font = .systemFont(ofSize: 16)
        return textField
    }()
    
    private let submitButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("立即反馈", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = TYConstants.UI.themeColor
        button.layer.cornerRadius = 22
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        return button
    }()
    
    // MARK: - Properties
    private var selectedImages: [UIImage] = []
    private let maxImageCount = 3
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupActions()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        title = "意见反馈"
        view.backgroundColor = .systemGroupedBackground
        
        // 设置集合视图
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        imageCollectionView.register(FeedbackImageCell.self, forCellWithReuseIdentifier: "ImageCell")
        imageCollectionView.register(AddImageCell.self, forCellWithReuseIdentifier: "AddCell")
        
        // 设置文本视图代理
        feedbackTextView.delegate = self
        
        // 添加视图
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(feedbackTextView)
        feedbackTextView.addSubview(placeholderLabel)
        contentView.addSubview(imageCollectionView)
        contentView.addSubview(contactTextField)
        contentView.addSubview(submitButton)
        
        // 设置约束
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        feedbackTextView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(160)
        }
        
        placeholderLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.left.equalToSuperview().offset(16)
        }
        
        imageCollectionView.snp.makeConstraints { make in
            make.top.equalTo(feedbackTextView.snp.bottom).offset(16)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(80)
        }
        
        contactTextField.snp.makeConstraints { make in
            make.top.equalTo(imageCollectionView.snp.bottom).offset(16)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(44)
        }
        
        submitButton.snp.makeConstraints { make in
            make.top.equalTo(contactTextField.snp.bottom).offset(32)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(44)
            make.bottom.equalToSuperview().offset(-32)
        }
    }
    
    private func setupActions() {
        submitButton.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
    }
    
    @objc private func submitTapped() {
        // 验证输入
        guard let feedback = feedbackTextView.text, !feedback.isEmpty else {
            showAlert(message: "请输入反馈内容")
            return
        }
        
        guard let contact = contactTextField.text, !contact.isEmpty else {
            showAlert(message: "请输入联系方式")
            return
        }
        
        // 验证联系方式格式
        let isValidEmail = contact.contains("@") && contact.contains(".")
        let isValidPhone = contact.count == 11 && contact.allSatisfy { $0.isNumber }
        
        guard isValidEmail || isValidPhone else {
            showAlert(message: "请输入正确的邮箱或手机号码")
            return
        }
        
        // 显示加载提示
        let loadingAlert = UIAlertController(title: nil, message: "正在提交...", preferredStyle: .alert)
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = .medium
        loadingIndicator.startAnimating()
        loadingAlert.view.addSubview(loadingIndicator)
        present(loadingAlert, animated: true)
        
        // 构建反馈内容
        let feedbackContent = """
        反馈内容：\(feedback)
        联系方式：\(contact)
        图片数量：\(selectedImages.count)
        """
        
        // 调用智谱接口
        ZhipuAIService.shared.sendMessage(feedbackContent) { [weak self] result in
            guard let self = self else { return }
            
            // 关闭加载提示
            loadingAlert.dismiss(animated: true) {
                switch result {
                case .success:
                    // 显示成功提示
                    let successAlert = UIAlertController(
                        title: "提交成功",
                        message: "感谢你的反馈，我们将尽快核对信息",
                        preferredStyle: .alert
                    )
                    successAlert.addAction(UIAlertAction(title: "确定", style: .default) { _ in
                        self.navigationController?.popViewController(animated: true)
                    })
                    self.present(successAlert, animated: true)
                    
                case .failure:
                    // 显示错误提示
                    self.showAlert(message: "系统繁忙，请重试")
                }
            }
        }
    }
}

// MARK: - UITextViewDelegate
extension FeedbackViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !textView.text.isEmpty
    }
}

// MARK: - UICollectionViewDelegate & DataSource
extension FeedbackViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedImages.count + (selectedImages.count < maxImageCount ? 1 : 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == selectedImages.count {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddCell", for: indexPath) as! AddImageCell
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! FeedbackImageCell
            cell.configure(with: selectedImages[indexPath.item])
            cell.delegate = self
            cell.tag = indexPath.item
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == selectedImages.count {
            showFeedPhotosPicker()
        }
    }
}

// MARK: - PHPickerViewControllerDelegate
extension FeedbackViewController: PHPickerViewControllerDelegate {
    private func showFeedPhotosPicker() {
        self.showImagePicker()
    }
    
    @available(iOS 14.0, *)

    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        for result in results {
            result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] object, error in
                if let image = object as? UIImage {
                    DispatchQueue.main.async {
                        self?.selectedImages.append(image)
                        self?.imageCollectionView.reloadData()
                    }
                }
            }
        }
    }
    override func handleSelectedImage(_ image: UIImage) {
        DispatchQueue.main.async {
            self.selectedImages.append(image)
            self.imageCollectionView.reloadData()
        }
    }
}

// MARK: - FeedbackImageCellDelegate
extension FeedbackViewController: FeedbackImageCellDelegate {
    func feedbackImageCellDidTapDelete(_ cell: FeedbackImageCell) {
        selectedImages.remove(at: cell.tag)
        imageCollectionView.reloadData()
    }
}

// MARK: - Cells
protocol FeedbackImageCellDelegate: AnyObject {
    func feedbackImageCellDidTapDelete(_ cell: FeedbackImageCell)
}

class FeedbackImageCell: UICollectionViewCell {
    weak var delegate: FeedbackImageCellDelegate?
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    private let deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(imageView)
        contentView.addSubview(deleteButton)
        
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        deleteButton.snp.makeConstraints { make in
            make.top.right.equalToSuperview()
            make.width.height.equalTo(24)
        }
        
        deleteButton.addTarget(self, action: #selector(deleteTapped), for: .touchUpInside)
    }
    
    func configure(with image: UIImage) {
        imageView.image = image
    }
    
    @objc private func deleteTapped() {
        delegate?.feedbackImageCellDidTapDelete(self)
    }
}

class AddImageCell: UICollectionViewCell {
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "plus.circle")
        imageView.tintColor = .systemGray3
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 8
        
        contentView.addSubview(iconImageView)
        iconImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(30)
        }
    }
} 
