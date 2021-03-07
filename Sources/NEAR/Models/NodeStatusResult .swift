import Foundation

public struct NodeStatusResult : Codable {
    let version: Version
    let chainID: String
    let protocolVersion: UInt
    let latestProtocolVersion: Int
    let rpcAddr: String
    let validators: [Validator]
    let syncInfo: SyncInfo
    let validatorAccountID: AccountId?

    enum CodingKeys: String, CodingKey {
        case version
        case chainID = "chain_id"
        case protocolVersion = "protocol_version"
        case latestProtocolVersion = "latest_protocol_version"
        case rpcAddr = "rpc_addr"
        case validators
        case syncInfo = "sync_info"
        case validatorAccountID = "validator_account_id"
    }
}

public struct SyncInfo: Codable {
    let latestBlockHash: String
    let latestBlockHeight: Int
    let latestStateRoot, latestBlockTime: String
    let syncing: Bool

    enum CodingKeys: String, CodingKey {
        case latestBlockHash = "latest_block_hash"
        case latestBlockHeight = "latest_block_height"
        case latestStateRoot = "latest_state_root"
        case latestBlockTime = "latest_block_time"
        case syncing
    }
}

public struct Validator: Codable {
    let accountID: AccountId
    let isSlashed: Bool

    enum CodingKeys: String, CodingKey {
        case accountID = "account_id"
        case isSlashed = "is_slashed"
    }
}

public struct Version: Codable {
    let version, build: String
}
