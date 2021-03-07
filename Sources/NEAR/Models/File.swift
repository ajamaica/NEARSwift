import Foundation

struct ViewAccessKeyListAllRequest: Codable {
    let changesType: String
    let accountIDS: [AccountId]
    let blockID: BlockId

    enum CodingKeys: String, CodingKey {
        case changesType = "changes_type"
        case accountIDS = "account_ids"
        case blockID = "block_id"
    }
}
