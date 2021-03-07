//
//  File.swift
//  
//
//  Created by Arturo Jamaica on 2021/03/07.
//

import Foundation

public struct BlockChangesRequest: Encodable {
    let blockIdOrFinality : BlockIdFinality
    
    enum CodingKeys: String, CodingKey {
        case blockID = "block_id"
        case finality = "finality"
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
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

public struct BlockChangesResponse: Codable {
    let blockHash: String
    let changes: [BlockChange]

    enum CodingKeys: String, CodingKey {
        case blockHash = "block_hash"
        case changes
    }
}

public struct BlockChange: Codable {
    let type, accountID: String

    enum CodingKeys: String, CodingKey {
        case type
        case accountID = "account_id"
    }
}

