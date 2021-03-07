//
//  File.swift
//  
//
//  Created by Arturo Jamaica on 2021/03/03.
//

import Foundation

public struct ViewAccessKeyListRequest: Encodable {
    let requestType = "view_access_key_list"
    let blockIdOrFinality: BlockIdFinality
    let accountID: AccountId

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

public struct ViewAccessKeyListResponse: Decodable {
    let keys: [Key]
    let blockHeight: Int
    let blockHash: String

    enum CodingKeys: String, CodingKey {
        case keys
        case blockHeight = "block_height"
        case blockHash = "block_hash"
    }
}
