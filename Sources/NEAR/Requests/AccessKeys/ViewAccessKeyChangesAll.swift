import Foundation

public struct ViewAccessKeyChangesAllRequest: Encodable {
    let changesType: String = "all_access_key_changes"
    let accountIDS: [String]
    let blockIdOrFinality: BlockIdFinality

    enum CodingKeys: String, CodingKey {
        case changesType = "changes_type"
        case accountIDS = "account_ids"
        case blockID = "block_id"
        case finality = "finality"
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(changesType, forKey: .changesType)
        try container.encode(accountIDS, forKey: .accountIDS)
        switch self.blockIdOrFinality {
        case .blockId(let x):
            try container.encode(x, forKey: .blockID)
        case .finality(let x):
            try container.encode(x, forKey: .finality)
        case .hash(let x):
            try container.encode(x, forKey: .blockID)
        }
    }
}

public struct ViewAccessKeyChangesAllResponse: Codable {
    let blockHash: String
    let changes: [ChangeElement]

    enum CodingKeys: String, CodingKey {
        case blockHash = "block_hash"
        case changes
    }
}
