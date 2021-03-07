//
//  File.swift
//  
//
//  Created by Arturo Jamaica on 2021/03/07.
//

import Foundation

public struct ViewContractStateChangesRequest: Encodable {
    let changesType: String = "data_changes"
    let accountIDS: [AccountId]
    let keyPrefixBase64: String
    let blockIdOrFinality : BlockIdFinality

    enum CodingKeys: String, CodingKey {
        case changesType = "changes_type"
        case accountIDS = "account_ids"
        case keyPrefixBase64 = "key_prefix_base64"
        case blockID = "block_id"
        case finality = "finality"
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(changesType, forKey: .changesType)
        try container.encode(accountIDS, forKey: .accountIDS)
        try container.encode(keyPrefixBase64, forKey: .keyPrefixBase64)
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

public struct ViewContractStateChangesResponse: Codable {
    let blockHash: String
    let changes: [ContractChangeElement]

    enum CodingKeys: String, CodingKey {
        case blockHash = "block_hash"
        case changes
    }
}


// MARK: - ChangeElement
struct ContractChangeElement: Codable {
    let cause: ContractChangeCause
    let type: String
    let change: ContractChangeChange
}

// MARK: - Cause
struct ContractChangeCause: Codable {
    let type, receiptHash: String

    enum CodingKeys: String, CodingKey {
        case type
        case receiptHash = "receipt_hash"
    }
}

// MARK: - ChangeChange
struct ContractChangeChange: Codable {
    let accountID, codeBase64: String

    enum CodingKeys: String, CodingKey {
        case accountID = "account_id"
        case codeBase64 = "code_base64"
    }
}
