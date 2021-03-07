import Foundation

public struct ViewAccessKeysRequest: Encodable {
    let requestType = "view_access_key"
    let accountID: AccountId
    let publicKey: PublicKey
    let blockIdOrFinality: BlockIdFinality

    enum CodingKeys: String, CodingKey {
        case requestType = "request_type"
        case finality
        case blockID = "block_id"
        case accountID = "account_id"
        case publicKey = "public_key"
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(requestType, forKey: .requestType)
        try container.encode(accountID, forKey: .accountID)
        try container.encode(publicKey, forKey: .publicKey)
        switch blockIdOrFinality {
        case .blockId(let x):
            try container.encode(x, forKey: .blockID)
        case .finality(let x):
            try container.encode(x, forKey: .finality)
        case .hash(let x):
            try container.encode(x, forKey: .blockID)
        }
    }
}

public struct ViewAccessKeysResponse: Decodable {
    let nonce: Int
    let permission: Permission
    let blockHeight: Int
    let blockHash: String

    enum CodingKeys: String, CodingKey {
        case nonce, permission
        case blockHeight = "block_height"
        case blockHash = "block_hash"
    }
}



