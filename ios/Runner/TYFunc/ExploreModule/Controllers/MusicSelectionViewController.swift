import UIKit

class MusicSelectionViewController: UIViewController {
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    private let musicService = MusicService.shared
    
    private let switchContainer = UIView()
    private let switchLabel = UILabel()
    private let musicSwitch = UISwitch()
    
    private let musics = [
        ("晨曦之歌", "晨曦之歌"),
        ("和谐的心弦", "和谐的心弦"),
        ("旅行的旋律", "旅行的旋律"),
        ("琵琶旋律", "琵琶旋律"),
        ("下雨天", "下雨天"),
        ("校园", "校园"),
        ("夜晚的思恋", "夜晚的思恋"),
        ("悠扬的旋律", "悠扬的旋律"),
        ("自由之歌", "自由之歌"),
        ("Beautiful Goodbye", "Beautiful Goodbye")
    ]
    
    private let disclaimerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 12
        
        let label = UILabel()
        label.text = "音乐由AI生成，仅供个人使用，不涉及版权问题。禁止用于商业用途或其他非法活动。"
        label.font = TYConstants.UI.Font.caption
        label.textColor = .systemGray
        label.numberOfLines = 0
        
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(12)
        }
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        title = "背景音乐"
        view.backgroundColor = .systemGroupedBackground
        
        // 设置开关容器
        switchContainer.backgroundColor = .white
        switchContainer.layer.cornerRadius = 12
        
        switchLabel.text = "背景音乐"
        switchLabel.font = TYConstants.UI.Font.body
        
        musicSwitch.isOn = musicService.isPlaying
        musicSwitch.onTintColor = TYConstants.UI.themeColor
        musicSwitch.addTarget(self, action: #selector(switchValueChanged), for: .valueChanged)
        
        switchContainer.addSubview(switchLabel)
        switchContainer.addSubview(musicSwitch)
        
        switchLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
        }
        
        musicSwitch.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
        }
        
        // 设置表格视图
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        // 添加视图
        view.addSubview(switchContainer)
        view.addSubview(disclaimerView)
        view.addSubview(tableView)
        
        // 布局
        switchContainer.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
        
        disclaimerView.snp.makeConstraints { make in
            make.top.equalTo(switchContainer.snp.bottom).offset(16)
            make.left.right.equalToSuperview().inset(16)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(disclaimerView.snp.bottom).offset(16)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    @objc private func switchValueChanged(_ sender: UISwitch) {
        if sender.isOn {
            if let lastMusic = musicService.currentMusic {
                musicService.resumeMusic()
            } else {
                musicService.playMusic("晨曦之歌")
            }
        } else {
            musicService.pauseMusic()
        }
        tableView.reloadData()
    }
}

extension MusicSelectionViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let music = musics[indexPath.row]
        cell.textLabel?.text = music.0
        
        // 标记当前播放的音乐，只有在开关打开时显示勾选
        if musicSwitch.isOn && music.1 == musicService.currentMusic {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let music = musics[indexPath.row]
        
        // 如果开关是关闭状态，先打开开关
        if !musicSwitch.isOn {
            musicSwitch.setOn(true, animated: true)
        }
        
        // 播放选中的音乐
        musicService.playMusic(music.1)
        tableView.reloadData()
    }
} 