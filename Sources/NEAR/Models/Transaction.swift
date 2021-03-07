import Foundation

public struct Transaction: Codable {
    let signerID: String
    let publicKey: String
    let nonce: Int
    let receiverID: String
    let actions: [Action]
    let signature: String
    let hash: String

    enum CodingKeys: String, CodingKey {
        case signerID = "signer_id"
        case publicKey = "public_key"
        case nonce
        case receiverID = "receiver_id"
        case actions
        case signature
        case hash
    }
}
