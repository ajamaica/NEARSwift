import Foundation

public struct AccountKey: Codable {
    let accountId: String
    let publicKey: PublicKey

    enum CodingKeys: String, CodingKey {
        case accountId = "account_id"
        case publicKey = "public_key"
    }
}
