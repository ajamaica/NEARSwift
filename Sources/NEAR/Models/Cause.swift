import Foundation

struct Cause: Codable {
    let type, txHash: String

    enum CodingKeys: String, CodingKey {
        case type
        case txHash = "tx_hash"
    }
}
