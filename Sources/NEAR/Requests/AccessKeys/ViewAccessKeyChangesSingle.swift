//
//  File 2.swift
//  
//
//  Created by Arturo Jamaica on 2021/03/07.
//

import Foundation

public struct ViewAccessKeyChangesSingleRequest: Encodable {
    let changesType: String = "single_access_key_changes"
    let keys: [AccountKey]
    let blockIdOrFinality: BlockIdFinality
    
    enum CodingKeys: String, CodingKey {
        case changesType = "changes_type"
        case keys
        case blockID = "block_id"
        case finality = "finality"
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(changesType, forKey: .changesType)
        try container.encode(keys, forKey: .keys)
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

enum BlockIdFinality: Encodable {
    case blockId(Int)
    case finality(Finality)
    case hash(String)
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .blockId(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .hash(x)
            return
        }
        if let x = try? container.decode(Finality.self) {
            self = .finality(x)
            return
        }
        throw DecodingError.typeMismatch(BlockIdFinality.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for BlockIDFinality"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .blockId(let x):
            try container.encode(x)
        case .finality(let x):
            try container.encode(x)
        case .hash(let x):
            try container.encode(x)
        }
    }
}


public struct ViewAccessKeyChangesSingleResponse: Codable {
    let blockHash: String
    let changes: [ChangeElement]

    enum CodingKeys: String, CodingKey {
        case blockHash = "block_hash"
        case changes
    }
}
