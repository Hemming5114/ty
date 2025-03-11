struct SettingItem {
    enum AccessoryType {
        case toggle
        case arrow
        case none
    }
    
    let icon: String
    let title: String
    let type: AccessoryType
} 