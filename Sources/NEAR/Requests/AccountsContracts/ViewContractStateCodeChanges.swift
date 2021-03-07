//
//  File.swift
//  
//
//  Created by Arturo Jamaica on 2021/03/07.
//


import Foundation

public struct ViewContractStateCodeChangesRequest: Encodable {
    let changesType: String = "contract_code_changes"
    let accountIDS: [AccountId]
    let blockIdOrFinality : BlockIdFinality

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

public struct ViewContractStateCodeChangesResponse: Codable {
    let blockHash: String
    let changes: [CodeChangeElement]

    enum CodingKeys: String, CodingKey {
        case blockHash = "block_hash"
        case changes
    }
}

// MARK: - ChangeElement
struct CodeChangeElement: Codable {
    let cause: CodeCause
    let type: String
    let change: CodeChangeChange
}

// MARK: - Cause
struct CodeCause: Codable {
    let type, receiptHash: String

    enum CodingKeys: String, CodingKey {
        case type
        case receiptHash = "receipt_hash"
    }
}

// MARK: - ChangeChange
struct CodeChangeChange: Codable {
    let accountID, codeBase64: String

    enum CodingKeys: String, CodingKey {
        case accountID = "account_id"
        case codeBase64 = "code_base64"
    }
}
