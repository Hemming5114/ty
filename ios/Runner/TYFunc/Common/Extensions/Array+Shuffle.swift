import Foundation

extension Array {
    mutating func shuffle() {
        for i in 0..<(count - 1) {
            let j = Int(arc4random_uniform(UInt32(count - i))) + i
            if i != j {
                self.swapAt(i, j)
            }
        }
    }
    
    func shuffled() -> [Element] {
        var array = self
        array.shuffle()
        return array
    }
} 