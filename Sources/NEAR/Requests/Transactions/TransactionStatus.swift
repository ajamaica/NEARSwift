//
//  File.swift
//  
//
//  Created by Arturo Jamaica on 2021/03/07.
//

import Foundation

public struct TransactionStatusRequest: Encodable {
    let transactionHash: String
    let accountId: AccountId
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode([transactionHash, accountId])
    }
}

public struct TransactionStatusResponse: Codable {
    let status: TransactionStatusResponseStatus
    let transaction: Transaction
    let transactionOutcome: TransactionOutcome
    let receiptsOutcome: [ReceiptsOutcome]

    enum CodingKeys: String, CodingKey {
        case status
        case transaction
        case transactionOutcome = "transaction_outcome"
        case receiptsOutcome = "receipts_outcome"
    }
}

struct TransactionStatusResponseStatus: Codable {
    let successValue: String

    enum CodingKeys: String, CodingKey {
        case successValue = "SuccessValue"
    }
}
