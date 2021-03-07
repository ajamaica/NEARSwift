import Foundation

public struct ChangeElement: Codable {
    let cause: Cause
    let type: String
    let change: ChangeChange
}
