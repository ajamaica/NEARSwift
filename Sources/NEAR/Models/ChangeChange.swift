import Foundation

struct ChangeChange: Codable {
    let accountID, publicKey: String
    let accessKey: AccessKey

    enum CodingKeys: String, CodingKey {
        case accountID = "account_id"
        case publicKey = "public_key"
        case accessKey = "access_key"
    }
}
