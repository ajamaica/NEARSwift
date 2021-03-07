//
//  File.swift
//  
//
//  Created by Arturo Jamaica on 2021/03/07.
//

import Foundation

public struct GenesisConfigResponse: Codable {
    let protocolVersion: Int
    let genesisTime, chainID: String
    let genesisHeight, numBlockProducerSeats: Int
    let numBlockProducerSeatsPerShard, avgHiddenValidatorSeatsPerShard: [Int]
    let dynamicResharding: Bool
    let protocolUpgradeStakeThreshold: [Int]
    let protocolUpgradeNumEpochs, epochLength, gasLimit: Int
    let minGasPrice, maxGasPrice: String
    let blockProducerKickoutThreshold, chunkProducerKickoutThreshold: Int
    let onlineMinThreshold, onlineMaxThreshold, gasPriceAdjustmentRate: [Int]
    let runtimeConfig: RuntimeConfig
    let validators: [GenesisValidator]
    let transactionValidityPeriod: Int
    let protocolRewardRate, maxInflationRate: [Int]
    let totalSupply: String
    let numBlocksPerYear: Int
    let protocolTreasuryAccount, fishermenThreshold: String
    let minimumStakeDivisor: Int

    enum CodingKeys: String, CodingKey {
        case protocolVersion = "protocol_version"
        case genesisTime = "genesis_time"
        case chainID = "chain_id"
        case genesisHeight = "genesis_height"
        case numBlockProducerSeats = "num_block_producer_seats"
        case numBlockProducerSeatsPerShard = "num_block_producer_seats_per_shard"
        case avgHiddenValidatorSeatsPerShard = "avg_hidden_validator_seats_per_shard"
        case dynamicResharding = "dynamic_resharding"
        case protocolUpgradeStakeThreshold = "protocol_upgrade_stake_threshold"
        case protocolUpgradeNumEpochs = "protocol_upgrade_num_epochs"
        case epochLength = "epoch_length"
        case gasLimit = "gas_limit"
        case minGasPrice = "min_gas_price"
        case maxGasPrice = "max_gas_price"
        case blockProducerKickoutThreshold = "block_producer_kickout_threshold"
        case chunkProducerKickoutThreshold = "chunk_producer_kickout_threshold"
        case onlineMinThreshold = "online_min_threshold"
        case onlineMaxThreshold = "online_max_threshold"
        case gasPriceAdjustmentRate = "gas_price_adjustment_rate"
        case runtimeConfig = "runtime_config"
        case validators
        case transactionValidityPeriod = "transaction_validity_period"
        case protocolRewardRate = "protocol_reward_rate"
        case maxInflationRate = "max_inflation_rate"
        case totalSupply = "total_supply"
        case numBlocksPerYear = "num_blocks_per_year"
        case protocolTreasuryAccount = "protocol_treasury_account"
        case fishermenThreshold = "fishermen_threshold"
        case minimumStakeDivisor = "minimum_stake_divisor"
    }
}

// MARK: - RuntimeConfig
struct RuntimeConfig: Codable {
    let storageAmountPerByte: String
    let transactionCosts: TransactionCosts
    let wasmConfig: WASMConfig
    let accountCreationConfig: AccountCreationConfig

    enum CodingKeys: String, CodingKey {
        case storageAmountPerByte = "storage_amount_per_byte"
        case transactionCosts = "transaction_costs"
        case wasmConfig = "wasm_config"
        case accountCreationConfig = "account_creation_config"
    }
}

// MARK: - AccountCreationConfig
struct AccountCreationConfig: Codable {
    let minAllowedTopLevelAccountLength: Int
    let registrarAccountID: String

    enum CodingKeys: String, CodingKey {
        case minAllowedTopLevelAccountLength = "min_allowed_top_level_account_length"
        case registrarAccountID = "registrar_account_id"
    }
}

// MARK: - TransactionCosts
struct TransactionCosts: Codable {
    let actionReceiptCreationConfig: ActionReceiptCreationConfig
    let dataReceiptCreationConfig: DataReceiptCreationConfig
    let actionCreationConfig: ActionCreationConfig
    let storageUsageConfig: StorageUsageConfig
    let burntGasReward, pessimisticGasPriceInflationRatio: [Int]

    enum CodingKeys: String, CodingKey {
        case actionReceiptCreationConfig = "action_receipt_creation_config"
        case dataReceiptCreationConfig = "data_receipt_creation_config"
        case actionCreationConfig = "action_creation_config"
        case storageUsageConfig = "storage_usage_config"
        case burntGasReward = "burnt_gas_reward"
        case pessimisticGasPriceInflationRatio = "pessimistic_gas_price_inflation_ratio"
    }
}

// MARK: - ActionCreationConfig
struct ActionCreationConfig: Codable {
    let createAccountCost, deployContractCost, deployContractCostPerByte, functionCallCost: ActionReceiptCreationConfig
    let functionCallCostPerByte, transferCost, stakeCost: ActionReceiptCreationConfig
    let addKeyCost: AddKeyCost
    let deleteKeyCost, deleteAccountCost: ActionReceiptCreationConfig

    enum CodingKeys: String, CodingKey {
        case createAccountCost = "create_account_cost"
        case deployContractCost = "deploy_contract_cost"
        case deployContractCostPerByte = "deploy_contract_cost_per_byte"
        case functionCallCost = "function_call_cost"
        case functionCallCostPerByte = "function_call_cost_per_byte"
        case transferCost = "transfer_cost"
        case stakeCost = "stake_cost"
        case addKeyCost = "add_key_cost"
        case deleteKeyCost = "delete_key_cost"
        case deleteAccountCost = "delete_account_cost"
    }
}

// MARK: - AddKeyCost
struct AddKeyCost: Codable {
    let fullAccessCost, functionCallCost, functionCallCostPerByte: ActionReceiptCreationConfig

    enum CodingKeys: String, CodingKey {
        case fullAccessCost = "full_access_cost"
        case functionCallCost = "function_call_cost"
        case functionCallCostPerByte = "function_call_cost_per_byte"
    }
}

// MARK: - ActionReceiptCreationConfig
struct ActionReceiptCreationConfig: Codable {
    let sendSir, sendNotSir, execution: Int

    enum CodingKeys: String, CodingKey {
        case sendSir = "send_sir"
        case sendNotSir = "send_not_sir"
        case execution
    }
}

// MARK: - DataReceiptCreationConfig
struct DataReceiptCreationConfig: Codable {
    let baseCost, costPerByte: ActionReceiptCreationConfig

    enum CodingKeys: String, CodingKey {
        case baseCost = "base_cost"
        case costPerByte = "cost_per_byte"
    }
}

// MARK: - StorageUsageConfig
struct StorageUsageConfig: Codable {
    let numBytesAccount, numExtraBytesRecord: Int

    enum CodingKeys: String, CodingKey {
        case numBytesAccount = "num_bytes_account"
        case numExtraBytesRecord = "num_extra_bytes_record"
    }
}

// MARK: - WASMConfig
struct WASMConfig: Codable {
    let extCosts: [String: Int]
    let growMemCost, regularOpCost: Int
    let limitConfig: [String: Int]

    enum CodingKeys: String, CodingKey {
        case extCosts = "ext_costs"
        case growMemCost = "grow_mem_cost"
        case regularOpCost = "regular_op_cost"
        case limitConfig = "limit_config"
    }
}

// MARK: - Validator
struct GenesisValidator: Codable {
    let accountID, publicKey, amount: String

    enum CodingKeys: String, CodingKey {
        case accountID = "account_id"
        case publicKey = "public_key"
        case amount
    }
}
