import Foundation

public struct ViewAccountRequest: Encodable {
    let requestType = "view_account"
    let accountID: String
    let blockIdOrFinality : BlockIdFinality
    
    enum CodingKeys: String, CodingKey {
        case requestType = "request_type"
        case blockID = "block_id"
        case finality = "finality"
        case accountID = "account_id"
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(requestType, forKey: .requestType)
        try container.encode(accountID, forKey: .accountID)
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

public struct ViewAccountResponse: Codable {
    let amount, locked, codeHash: String
    let storageUsage, storagePaidAt, blockHeight: Int
    let blockHash: String

    enum CodingKeys: String, CodingKey {
        case amount, locked
        case codeHash = "code_hash"
        case storageUsage = "storage_usage"
        case storagePaidAt = "storage_paid_at"
        case blockHeight = "block_height"
        case blockHash = "block_hash"
    }
}

