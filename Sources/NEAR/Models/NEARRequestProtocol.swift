import Foundation

public enum Method: String, Encodable {
    case query
    case status
    case broadcast_tx_commit = "broadcast_tx_commit"
    case tx
    case block
    case chunk
    case validators
    case gas_price
    case experimental_changes = "EXPERIMENTAL_changes"
    case experimental_genesisConfig = "EXPERIMENTAL_genesis_config"
    case lightClientProof = "EXPERIMENTAL_light_client_proof"
}

public struct NEARRequest<Params: Encodable>: Encodable {
    let jsonrpc: String = "2.0"
    let id: String = "dontcare"
    let method: Method
    let params: Params?
}
