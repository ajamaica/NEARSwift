//
//  File.swift
//  
//
//  Created by Arturo Jamaica on 2021/03/07.
//

import Foundation

public struct CallContractFunctionRequest: Encodable {
    let requestType = "call_function"
    let accountID: String
    let methodName: String
    let blockIdOrFinality : BlockIdFinality
    let argsBase64: String

    enum CodingKeys: String, CodingKey {
        case requestType = "request_type"
        case blockID = "block_id"
        case finality = "finality"
        case accountID = "account_id"
        case methodName = "method_name"
        case argsBase64 = "args_base64"
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(requestType, forKey: .requestType)
        try container.encode(accountID, forKey: .accountID)
        try container.encode(argsBase64, forKey: .argsBase64)
        try container.encode(methodName, forKey: .methodName)
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

public struct CallContractFunctionResponse: Codable {
    let result: [Int]
    let logs: [JSONAny]
    let blockHeight: Int
    let blockHash: String

    enum CodingKeys: String, CodingKey {
        case result, logs
        case blockHeight = "block_height"
        case blockHash = "block_hash"
    }
}
