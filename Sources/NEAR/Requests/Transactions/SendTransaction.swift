import Foundation

public typealias SendTransactionRequest = [String]

public typealias SendTransactionAsyncResponse = String

public struct SendTransactionAwaitResponse: Codable {
    let status: SendTransactionResponseStatus
    let transaction: Transaction
    let transactionOutcome: TransactionOutcome
    let receiptsOutcome: [ReceiptsOutcome]

    enum CodingKeys: String, CodingKey {
        case status, transaction
        case transactionOutcome = "transaction_outcome"
        case receiptsOutcome = "receipts_outcome"
    }
}

public struct ReceiptsOutcome: Codable {
    let proof: [JSONAny]
    let blockHash, id: String
    let outcome: ReceiptsOutcomeOutcome

    enum CodingKeys: String, CodingKey {
        case proof
        case blockHash = "block_hash"
        case id, outcome
    }
}

public struct ReceiptsOutcomeOutcome: Codable {
    let logs: [JSONAny]
    let receiptIDS: [String]
    let gasBurnt: Int
    let tokensBurnt, executorID: String
    let status: SendTransactionResponseStatus

    enum CodingKeys: String, CodingKey {
        case logs
        case receiptIDS = "receipt_ids"
        case gasBurnt = "gas_burnt"
        case tokensBurnt = "tokens_burnt"
        case executorID = "executor_id"
        case status
    }
}

public struct SendTransactionResponseStatus: Codable {
    let successValue: String

    enum CodingKeys: String, CodingKey {
        case successValue = "SuccessValue"
    }
}

// MARK: - TransactionOutcomeOutcome
struct TransactionOutcomeOutcome: Codable {
    let logs: [JSONAny]
    let receiptIDS: [String]
    let gasBurnt: Int
    let tokensBurnt, executorID: String
    let status: PurpleStatus

    enum CodingKeys: String, CodingKey {
        case logs
        case receiptIDS = "receipt_ids"
        case gasBurnt = "gas_burnt"
        case tokensBurnt = "tokens_burnt"
        case executorID = "executor_id"
        case status
    }
}

public struct TransactionOutcome: Codable {
    let proof: [Proof]
    let blockHash, id: String
    let outcome: TransactionOutcomeOutcome

    enum CodingKeys: String, CodingKey {
        case proof
        case blockHash = "block_hash"
        case id, outcome
    }
}

