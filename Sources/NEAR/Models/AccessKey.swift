import Foundation

public struct AccessKey: Codable {
    let nonce: Int
    let permission: PermissionUnion
}
