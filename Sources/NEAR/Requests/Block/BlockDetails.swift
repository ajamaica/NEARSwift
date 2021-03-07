//
//  File.swift
//  
//
//  Created by Arturo Jamaica on 2021/03/07.
//

import Foundation

public struct BlockDetailsRequest: Encodable {
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

public struct BlockDetailsResponse: Codable {
    let author: String
    let header: Header
    let chunks: [Chunk]
}

public struct Chunk: Codable {
    let chunkHash, prevBlockHash, outcomeRoot, prevStateRoot: String
    let encodedMerkleRoot: String
    let encodedLength, heightCreated, heightIncluded, shardID: Int
    let gasUsed, gasLimit: Int
    let rentPaid, validatorReward, balanceBurnt, outgoingReceiptsRoot: String
    let txRoot: String
    let validatorProposals: [JSONAny]
    let signature: String

    enum CodingKeys: String, CodingKey {
        case chunkHash = "chunk_hash"
        case prevBlockHash = "prev_block_hash"
        case outcomeRoot = "outcome_root"
        case prevStateRoot = "prev_state_root"
        case encodedMerkleRoot = "encoded_merkle_root"
        case encodedLength = "encoded_length"
        case heightCreated = "height_created"
        case heightIncluded = "height_included"
        case shardID = "shard_id"
        case gasUsed = "gas_used"
        case gasLimit = "gas_limit"
        case rentPaid = "rent_paid"
        case validatorReward = "validator_reward"
        case balanceBurnt = "balance_burnt"
        case outgoingReceiptsRoot = "outgoing_receipts_root"
        case txRoot = "tx_root"
        case validatorProposals = "validator_proposals"
        case signature
    }
}

public struct Header: Codable {
    let height: Int
    let epochID, nextEpochID, hash, prevHash: String
    let prevStateRoot, chunkReceiptsRoot, chunkHeadersRoot, chunkTxRoot: String
    let outcomeRoot: String
    let chunksIncluded: Int
    let challengesRoot: String
    let timestamp: Double
    let timestampNanosec, randomValue: String
    let validatorProposals: [JSONAny]
    let chunkMask: [Bool]
    let gasPrice, rentPaid, validatorReward, totalSupply: String
    let challengesResult: [JSONAny]
    let lastFinalBlock, lastDsFinalBlock, nextBpHash, blockMerkleRoot: String
    let approvals: [String?]
    let signature: String
    let latestProtocolVersion: Int

    enum CodingKeys: String, CodingKey {
        case height
        case epochID = "epoch_id"
        case nextEpochID = "next_epoch_id"
        case hash
        case prevHash = "prev_hash"
        case prevStateRoot = "prev_state_root"
        case chunkReceiptsRoot = "chunk_receipts_root"
        case chunkHeadersRoot = "chunk_headers_root"
        case chunkTxRoot = "chunk_tx_root"
        case outcomeRoot = "outcome_root"
        case chunksIncluded = "chunks_included"
        case challengesRoot = "challenges_root"
        case timestamp
        case timestampNanosec = "timestamp_nanosec"
        case randomValue = "random_value"
        case validatorProposals = "validator_proposals"
        case chunkMask = "chunk_mask"
        case gasPrice = "gas_price"
        case rentPaid = "rent_paid"
        case validatorReward = "validator_reward"
        case totalSupply = "total_supply"
        case challengesResult = "challenges_result"
        case lastFinalBlock = "last_final_block"
        case lastDsFinalBlock = "last_ds_final_block"
        case nextBpHash = "next_bp_hash"
        case blockMerkleRoot = "block_merkle_root"
        case approvals, signature
        case latestProtocolVersion = "latest_protocol_version"
    }
}
