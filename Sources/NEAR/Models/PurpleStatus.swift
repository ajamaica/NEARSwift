import Foundation

public struct PurpleStatus: Codable {
    let successReceiptID: String

    enum CodingKeys: String, CodingKey {
        case successReceiptID = "SuccessReceiptId"
    }
}
