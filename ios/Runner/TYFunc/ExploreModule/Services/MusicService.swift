import AVFoundation
import MediaPlayer

class MusicService {
    static let shared = MusicService()
    
    // 添加通知名称
    static let musicStateDidChangeNotification = Notification.Name("musicStateDidChangeNotification")
    
    private var audioPlayer: AVAudioPlayer?
    var currentMusic: String?
    var isPlaying: Bool {
        return audioPlayer?.isPlaying ?? false
    }
    
    // 音乐列表，后5首为VIP音乐
    let musics = [
        ("晨曦之歌", "晨曦之歌"),
        ("和谐的心弦", "和谐的心弦"),
        ("旅行的旋律", "旅行的旋律"),
        // 免费音乐
        ("琵琶旋律", "琵琶旋律"),
        ("下雨天", "下雨天"),
        // VIP音乐
        ("校园", "校园"),
        ("夜晚的思恋", "夜晚的思恋"),
        ("悠扬的旋律", "悠扬的旋律"),
        ("自由之歌", "自由之歌"),
        ("Beautiful Goodbye", "Beautiful Goodbye")
    ]
    
    // 判断音乐是否是VIP音乐
    func isVIPMusic(_ index: Int) -> Bool {
        return index >= musics.count - 5
    }
    
    // 判断音乐是否已购买
    func isMusicPurchased(_ musicName: String) -> Bool {
        let purchasedMusic = UserDefaults.standard.array(forKey: "PurchasedMusic") as? [String] ?? []
        return purchasedMusic.contains(musicName)
    }
    
    // 购买音乐
    func purchaseMusic(_ musicName: String) {
        var purchasedMusic = UserDefaults.standard.array(forKey: "PurchasedMusic") as? [String] ?? []
        purchasedMusic.append(musicName)
        UserDefaults.standard.set(purchasedMusic, forKey: "PurchasedMusic")
    }
    
    private init() {
        setupAudioSession()
        setupRemoteCommandCenter()
    }
    
    private func setupAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(
                .playback,
                mode: .default,
                options: [.mixWithOthers, .allowAirPlay]
            )
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Failed to setup audio session: \(error)")
        }
    }
    
    private func setupRemoteCommandCenter() {
        // 设置锁屏和控制中心的播放控制
        let commandCenter = MPRemoteCommandCenter.shared()
        
        commandCenter.playCommand.addTarget { [weak self] _ in
            self?.resumeMusic()
            return .success
        }
        
        commandCenter.pauseCommand.addTarget { [weak self] _ in
            self?.pauseMusic()
            return .success
        }
        
        // 设置锁屏界面显示的信息
        setupNowPlaying()
    }
    
    private func setupNowPlaying() {
        var nowPlayingInfo = [String: Any]()
        nowPlayingInfo[MPMediaItemPropertyTitle] = "桃遇背景音乐"
        nowPlayingInfo[MPMediaItemPropertyArtist] = "AI生成"
        
        if let image = UIImage(named: "AppIcon") {
            let artwork = MPMediaItemArtwork(boundsSize: image.size) { _ in image }
            nowPlayingInfo[MPMediaItemPropertyArtwork] = artwork
        }
        
        MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
    }
    
    func playMusic(_ name: String) {
        guard currentMusic != name else { return }
        
        if let path = Bundle.main.path(forResource: name, ofType: "mp3") {
            do {
                audioPlayer?.stop()
                audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                audioPlayer?.numberOfLoops = -1 // 循环播放
                audioPlayer?.prepareToPlay() // 预加载
                audioPlayer?.play()
                currentMusic = name
                
                // 发送状态变化通知
                NotificationCenter.default.post(
                    name: MusicService.musicStateDidChangeNotification,
                    object: self,
                    userInfo: ["isPlaying": true]
                )
                
                // 更新锁屏界面信息
                var nowPlayingInfo = MPNowPlayingInfoCenter.default().nowPlayingInfo ?? [:]
                nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackRate] = 1.0
                if let duration = audioPlayer?.duration {
                    nowPlayingInfo[MPMediaItemPropertyPlaybackDuration] = duration
                }
                MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
                
            } catch {
                print("Failed to play music: \(error)")
            }
        }
    }
    
    func pauseMusic() {
        audioPlayer?.pause()
        // 发送状态变化通知
        NotificationCenter.default.post(
            name: MusicService.musicStateDidChangeNotification,
            object: self,
            userInfo: ["isPlaying": false]
        )
        // 更新锁屏界面播放状态
        var nowPlayingInfo = MPNowPlayingInfoCenter.default().nowPlayingInfo ?? [:]
        nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackRate] = 0.0
        MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
    }
    
    func resumeMusic() {
        audioPlayer?.play()
        // 发送状态变化通知
        NotificationCenter.default.post(
            name: MusicService.musicStateDidChangeNotification,
            object: self,
            userInfo: ["isPlaying": true]
        )
        // 更新锁屏界面播放状态
        var nowPlayingInfo = MPNowPlayingInfoCenter.default().nowPlayingInfo ?? [:]
        nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackRate] = 1.0
        MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
    }
    
    func stopMusic() {
        audioPlayer?.stop()
        currentMusic = nil
        // 发送状态变化通知
        NotificationCenter.default.post(
            name: MusicService.musicStateDidChangeNotification,
            object: self,
            userInfo: ["isPlaying": false]
        )
        // 清除锁屏界面信息
        MPNowPlayingInfoCenter.default().nowPlayingInfo = nil
    }
    
    // 添加随机播放方法
    func playRandomMusic() {
        let musics = [
            "晨曦之歌",
            "和谐的心弦",
            "旅行的旋律",
            "琵琶旋律",
            "下雨天",
        ]
        
        if let randomMusic = musics.randomElement() {
            playMusic(randomMusic)
        }
    }
} 
