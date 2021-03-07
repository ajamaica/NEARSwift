import Foundation

public struct ViewContractStateRequest: Encodable {
    let requestType = "view_state"
    let accountID, prefixBase64: String

    let blockIdOrFinality : BlockIdFinality
    
    enum CodingKeys: String, CodingKey {
        case requestType = "request_type"
        case blockID = "block_id"
        case finality = "finality"
        case accountID = "account_id"
        case prefixBase64 = "prefix_base64"
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(requestType, forKey: .requestType)
        try container.encode(accountID, forKey: .accountID)
        try container.encode(prefixBase64, forKey: .prefixBase64)
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

public struct ViewContractStateResponse: Codable {
    let values: [Value]
    let proof: [JSONAny]
    let blockHeight: Int
    let blockHash: String

    enum CodingKeys: String, CodingKey {
        case values, proof
        case blockHeight = "block_height"
        case blockHash = "block_hash"
    }
}
