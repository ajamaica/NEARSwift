import Foundation

typealias PublicKey = String

public struct Key: Codable {
    let publicKey: PublicKey
    let accessKey: AccessKey

    enum CodingKeys: String, CodingKey {
        case publicKey = "public_key"
        case accessKey = "access_key"
    }
}
