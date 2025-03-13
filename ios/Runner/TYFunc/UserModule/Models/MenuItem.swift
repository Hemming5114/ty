struct MenuItem {
    let icon: String
    let title: String
    let color: UIColor
    let subtitle: String?
    
    init(icon: String, title: String, color: UIColor, subtitle: String? = nil) {
        self.icon = icon
        self.title = title
        self.color = color
        self.subtitle = subtitle
    }
} 