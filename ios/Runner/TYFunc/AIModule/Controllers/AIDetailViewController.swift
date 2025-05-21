import UIKit
import SnapKit

class AIDetailViewController: UIViewController {
    private let ai: AIModel
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    // MARK: - UI Components
    private let headerContainerView = UIView()
    private var headerImageViewHeightConstraint: Constraint?
    private let headerImageHeight = UIScreen.main.bounds.width
    
    private let headerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private let personalityLabel: UILabel = {
        let label = UILabel()
        label.font = TYConstants.UI.Font.subtitle
        label.textColor = TYConstants.UI.themeColor
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = TYConstants.UI.Font.body
        label.textColor = .darkGray
        label.numberOfLines = 0
        return label
    }()
    
    private let statsView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 12
        return view
    }()
    
    private let startChatButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("开始聊天", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = TYConstants.UI.themeColor
        button.layer.cornerRadius = 25
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        return button
    }()
    
    private let sectionStackView = UIStackView()
    
    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(systemName: "chevron.left")
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 18
        return button
    }()
    
    private let reportButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(systemName: "exclamationmark.triangle")
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 18
        return button
    }()
    private let blackButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(systemName: "person.slash")
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 18
        return button
    }()

    // MARK: - 初始化
    init(ai: AIModel) {
        self.ai = ai
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureContent()
        setupActions()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        view.backgroundColor = .white
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.delegate = self // 添加代理
        
        // 添加滚动视图
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        // 添加头部容器视图
        contentView.addSubview(headerContainerView)
        headerContainerView.addSubview(headerImageView)
        
        // 添加其他 UI 组件
        [nameLabel, personalityLabel, descriptionLabel, statsView, sectionStackView].forEach {
            contentView.addSubview($0)
        }
        
        // 添加导航按钮
        view.addSubview(backButton)
        view.addSubview(reportButton)
        view.addSubview(startChatButton)
        view.addSubview(blackButton)

        // 设置分区堆栈视图
        sectionStackView.axis = .vertical
        sectionStackView.spacing = 16
        
        // 添加图片点击手势
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(headerImageTapped))
        headerImageView.isUserInteractionEnabled = true
        headerImageView.addGestureRecognizer(tapGesture)
        
        setupConstraints()
        setupStatsView()
    }
    
    private func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.top.left.bottom.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        // 设置头部容器视图约束
        headerContainerView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(headerImageHeight)
        }
        
        // 设置头部图片约束
        headerImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            headerImageViewHeightConstraint = make.height.equalTo(headerImageHeight).constraint
        }
        
        // 其他视图相对于头部容器视图布局
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(headerContainerView.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
        }
        
        personalityLabel.snp.makeConstraints { make in
            make.centerY.equalTo(nameLabel)
            make.right.equalToSuperview().offset(-16)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
            make.left.right.equalToSuperview().inset(16)
        }
        
        statsView.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(16)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(80)
        }
        
        sectionStackView.snp.makeConstraints { make in
            make.top.equalTo(statsView.snp.bottom).offset(16)
            make.left.right.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().offset(-100)
        }
        
        startChatButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-16)
            make.height.equalTo(50)
        }
        
        // 设置导航按钮约束
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.equalToSuperview().offset(12)
            make.width.height.equalTo(44)
        }
        
        reportButton.snp.makeConstraints { make in
            make.top.equalTo(backButton)
            make.right.equalToSuperview().offset(-12)
            make.width.height.equalTo(44)
        }
        blackButton.snp.makeConstraints { make in
            make.top.equalTo(backButton)
            make.right.equalTo(reportButton.snp.left)
            make.width.height.equalTo(44)
        }

    }
    
    private func setupStatsView() {
        let ratingView = createStatsItem(
            icon: "star.fill",
            tintColor: .systemYellow,
            title: "评分"
        )
        let chatsView = createStatsItem(
            icon: "message.fill",
            tintColor: .systemBlue,
            title: "对话"
        )
        
        statsView.addSubview(ratingView)
        statsView.addSubview(chatsView)
        
        ratingView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(100)
            make.centerY.equalToSuperview()
        }
        
        chatsView.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-100)
            make.centerY.equalToSuperview()
        }
    }
    
    private func configureContent() {
        // 设置基本信息
        headerImageView.image = UIImage(named: ai.avatarImageName)
        nameLabel.text = ai.name
        personalityLabel.text = ai.personality
        descriptionLabel.text = ai.description
        
        // 设置统计数据
        if let ratingView = statsView.subviews.first?.subviews.last as? UILabel {
            ratingView.text = String(format: "%.1f", ai.rating)
        }
        if let chatsView = statsView.subviews.last?.subviews.last as? UILabel {
            chatsView.text = ai.totalChats.formatWithCommas()
        }
        
        // 添加特性部分
        addSection(title: "性格特点", items: ai.personality.components(separatedBy: "、"))
        addSection(title: "擅长领域", items: ai.specialties)
        addSection(title: "主要功能", items: ai.features)
        addSection(title: "标签", items: ai.tags)
        addSection(title: "背景故事", content: ai.background)
        addSection(title: "开场白", content: ai.openingMessage)
    }
    
    private func setupActions() {
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        reportButton.addTarget(self, action: #selector(reportButtonTapped), for: .touchUpInside)
        startChatButton.addTarget(self, action: #selector(startChatTapped), for: .touchUpInside)
        blackButton.addTarget(self, action: #selector(blackButtonTapped), for: .touchUpInside)

    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func reportButtonTapped() {
        let reportVC = ReportViewController(ai: ai)
        navigationController?.pushViewController(reportVC, animated: true)
    }
    @objc private func blackButtonTapped() {
        let alert = UIAlertController(
            title: "是否将(AI：\(ai.name))加入黑名单",
            message: "1、你将不再收到该AI的任何回复或内容推荐 \n 2、可通过「我的-黑名单」随时解除",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "暂不处理", style: .cancel))
        alert.addAction(UIAlertAction(title: "确认拉黑", style: .destructive) { [weak self] _ in
            guard let self = self else { return }

            ChatManager.shared.addBlockSession(ai.id)
            // 发送通知更新用户界面
            NotificationCenter.default.post(name: NSNotification.Name("UserBlockDidChangeNotification"), object: nil)
            self.navigationController?.popToRootViewController(animated: true)
                                    
        })
        
        present(alert, animated: true)
        
    }

    @objc private func startChatTapped() {
        let chatVC = ChatViewController(session: ChatSession(aiModel: ai))
        navigationController?.pushViewController(chatVC, animated: true)
    }
    
    @objc private func headerImageTapped() {
        let previewVC = ImagePreviewViewController(imageName: ai.avatarImageName)
        previewVC.modalPresentationStyle = .fullScreen
        present(previewVC, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // 不再在这里恢复导航栏显示
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    // MARK: - Helper Methods
    private func createStatsItem(icon: String, tintColor: UIColor, title: String) -> UIView {
        let container = UIView()
        
        let iconImageView = UIImageView(image: UIImage(systemName: icon))
        iconImageView.tintColor = tintColor
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = TYConstants.UI.Font.caption
        titleLabel.textColor = .gray
        
        let valueLabel = UILabel()
        valueLabel.font = .systemFont(ofSize: 16, weight: .medium)
        
        container.addSubview(iconImageView)
        container.addSubview(titleLabel)
        container.addSubview(valueLabel)
        
        iconImageView.snp.makeConstraints { make in
            make.top.centerX.equalToSuperview()
            make.width.height.equalTo(24)
        }
        
        valueLabel.snp.makeConstraints { make in
            make.top.equalTo(iconImageView.snp.bottom).offset(4)
            make.centerX.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(valueLabel.snp.bottom).offset(4)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        return container
    }
    
    private func addSection(title: String, items: [String]) {
        let sectionView = AISectionView(title: title)
        let itemsView = TagListView()
        itemsView.alignment = .left
        itemsView.tagBackgroundColor = .systemGray6
        itemsView.textColor = .label
        itemsView.cornerRadius = 12
        itemsView.paddingY = 8
        itemsView.paddingX = 12
        itemsView.marginX = 8
        itemsView.marginY = 8
        
        items.forEach { itemsView.addTag($0) }
        sectionView.addContentView(itemsView)
        sectionStackView.addArrangedSubview(sectionView)
    }
    
    private func addSection(title: String, content: String) {
        let sectionView = AISectionView(title: title)
        let label = UILabel()
        label.text = content
        label.numberOfLines = 0
        label.font = TYConstants.UI.Font.body
        label.textColor = .secondaryLabel
        sectionView.addContentView(label)
        sectionStackView.addArrangedSubview(sectionView)
    }
}

// MARK: - Supporting Views
class StatsItemView: UIView {
    private let iconImageView = UIImageView()
    private let titleLabel = UILabel()
    private let valueLabel = UILabel()
    private let stackView = UIStackView()
    
    init(icon: String, tintColor: UIColor, title: String) {
        super.init(frame: .zero)
        
        iconImageView.image = UIImage(systemName: icon)
        iconImageView.tintColor = tintColor
        
        titleLabel.text = title
        titleLabel.font = TYConstants.UI.Font.caption
        titleLabel.textColor = .gray
        
        valueLabel.font = .systemFont(ofSize: 16, weight: .medium)
        
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 4
        
        addSubview(stackView)
        stackView.addArrangedSubview(iconImageView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(valueLabel)
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        iconImageView.snp.makeConstraints { make in
            make.width.height.equalTo(20)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(title: String, value: String) {
        titleLabel.text = title
        valueLabel.text = value
    }
}

class AISectionView: UIView {
    private let titleLabel = UILabel()
    private let contentView = UIView()
    
    init(title: String) {
        super.init(frame: .zero)
        
        titleLabel.text = title
        titleLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        
        addSubview(titleLabel)
        addSubview(contentView)
        
        titleLabel.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addContentView(_ view: UIView) {
        contentView.addSubview(view)
        view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

class ImagePreviewViewController: UIViewController {
    private let imageName: String
    private let imageView = UIImageView()
    private var initialImageCenter: CGPoint = .zero
    private var currentScale: CGFloat = 1.0
    
    init(imageName: String) {
        self.imageName = imageName
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupGestures()
    }
    
    private func setupUI() {
        view.backgroundColor = .black
        
        // 设置图片视图
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: imageName)
        view.addSubview(imageView)
        
        // 添加关闭按钮
        let closeButton = UIButton(type: .system)
        closeButton.setTitle("关闭", for: .normal)
        closeButton.setTitleColor(.white, for: .normal)
        closeButton.addTarget(self, action: #selector(handleClose), for: .touchUpInside)
        
        // 添加保存按钮
        let saveButton = UIButton(type: .system)
        saveButton.setImage(UIImage(systemName: "square.and.arrow.down"), for: .normal)
        saveButton.tintColor = .white
        saveButton.addTarget(self, action: #selector(handleSave), for: .touchUpInside)
        
        view.addSubview(closeButton)
        view.addSubview(saveButton)
        
        // 布局
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.left.equalTo(16)
        }
        
        saveButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.right.equalTo(-16)
        }
    }
    
    private func setupGestures() {
        // 添加缩放手势
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch))
        view.addGestureRecognizer(pinchGesture)
        
        // 添加平移手势
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        view.addGestureRecognizer(panGesture)
        
        // 添加双击手势
        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap))
        doubleTapGesture.numberOfTapsRequired = 2
        view.addGestureRecognizer(doubleTapGesture)
    }
    
    @objc private func handleClose() {
        dismiss(animated: true)
    }
    
    @objc private func handleSave() {
        guard let image = imageView.image else { return }
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc private func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            showToast(message: "保存失败：\(error.localizedDescription)")
        } else {
            showToast(message: "已保存到相册")
        }
    }
    
    @objc private func handlePinch(_ gesture: UIPinchGestureRecognizer) {
        if gesture.state == .began {
            initialImageCenter = imageView.center
        }
        
        let scale = gesture.scale * currentScale
        let transform = CGAffineTransform(scaleX: scale, y: scale)
        imageView.transform = transform
        
        if gesture.state == .ended {
            currentScale = scale
        }
    }
    
    @objc private func handlePan(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        
        if gesture.state == .began {
            initialImageCenter = imageView.center
        }
        
        let newCenter = CGPoint(
            x: initialImageCenter.x + translation.x,
            y: initialImageCenter.y + translation.y
        )
        imageView.center = newCenter
        
        if gesture.state == .ended {
            initialImageCenter = newCenter
        }
    }
    
    @objc private func handleDoubleTap(_ gesture: UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.3) {
            if self.currentScale != 1.0 {
                // 重置缩放
                self.imageView.transform = .identity
                self.currentScale = 1.0
                self.imageView.center = self.view.center
            } else {
                // 放大到2倍
                self.imageView.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
                self.currentScale = 2.0
            }
        }
    }
    
    private func showToast(message: String) {
        let toast = UILabel()
        toast.text = message
        toast.textColor = .white
        toast.textAlignment = .center
        toast.font = .systemFont(ofSize: 16)
        toast.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        toast.layer.cornerRadius = 20
        toast.clipsToBounds = true
        
        view.addSubview(toast)
        toast.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.greaterThanOrEqualTo(200)
            make.height.equalTo(40)
        }
        
        // 2秒后隐藏
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            UIView.animate(withDuration: 0.3) {
                toast.alpha = 0
            } completion: { _ in
                toast.removeFromSuperview()
            }
        }
    }
}

// MARK: - UIScrollViewDelegate
extension AIDetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        
        // 下拉放大效果
        if offsetY < 0 {
            let newHeight = headerImageHeight - offsetY
            headerImageViewHeightConstraint?.update(offset: newHeight)
            
            // 保持图片底部固定，顶部放大
            headerImageView.snp.updateConstraints { make in
                make.bottom.equalToSuperview()
            }
        } else {
            // 恢复原始高度
            headerImageViewHeightConstraint?.update(offset: headerImageHeight)
        }
    }
} 
