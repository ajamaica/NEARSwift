//
//  File.swift
//  
//
//  Created by Arturo Jamaica on 2021/03/07.
//

import Foundation

public struct ViewAccountChangesRequest: Encodable {
    let changesType = "account_changes"
    let accountIds: [AccountId]
    let blockIdOrFinality : BlockIdFinality
    
    enum CodingKeys: String, CodingKey {
        case changesType = "changes_type"
        case blockID = "block_id"
        case finality = "finality"
        case accountIds = "account_ids"
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(changesType, forKey: .changesType)
        try container.encode(accountIds, forKey: .accountIds)
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

public struct ViewContractChangesResponse: Codable {
    let blockHash: String
    let changes: [ChangeElement]

    enum CodingKeys: String, CodingKey {
        case blockHash = "block_hash"
        case changes
    }
}
