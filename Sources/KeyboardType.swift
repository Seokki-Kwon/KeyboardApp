import Foundation

public enum KeyboardType {
    case korean
    case koreanShift
    
    public var keyMap: [[String]] {
        switch self {
        case .korean:
            [
                ["ㅂ", "ㅈ", "ㄷ", "ㄱ", "ㅅ", "ㅛ", "ㅕ", "ㅑ", "ㅐ", "ㅔ"],
                ["ㅁ", "ㄴ", "ㅇ", "ㄹ", "ㅎ", "ㅗ", "ㅓ", "ㅏ", "ㅣ"],
                ["↑", "ㅋ", "ㅌ", "ㅊ", "ㅍ", "ㅠ", "ㅜ", "ㅡ", "←"],
                ["숫자", "영어", "스페이스", "엔터"]
            ]
        case .koreanShift:
            [
                ["ㅃ", "ㅉ", "ㄸ", "ㄲ", "ㅆ", "ㅛ", "ㅕ", "ㅑ", "ㅒ", "ㅖ"],
                ["ㅁ", "ㄴ", "ㅇ", "ㄹ", "ㅎ", "ㅗ", "ㅓ", "ㅏ", "ㅣ"],
                ["↑", "ㅋ", "ㅌ", "ㅊ", "ㅍ", "ㅠ", "ㅜ", "ㅡ", "←"],
                ["숫자", "영어", "스페이스", "엔터"]
            ]
        }
    }
    
    mutating public func shift() {
        switch self {
        case .korean:
            self = .koreanShift
        case .koreanShift:
            self = .korean
        }
    }
}
