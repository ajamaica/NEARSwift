import Foundation

public struct Permission: Codable {
    let functionCall: FunctionCall

    enum CodingKeys: String, CodingKey {
        case functionCall = "FunctionCall"
    }
}

public struct FunctionCall: Codable {
    let allowance, receiverID: String
    let methodNames: [String]

    enum CodingKeys: String, CodingKey {
        case allowance
        case receiverID = "receiver_id"
        case methodNames = "method_names"
    }
}

enum PermissionUnion: Codable {
    case permission(Permission)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        if let x = try? container.decode(Permission.self) {
            self = .permission(x)
            return
        }
        throw DecodingError.typeMismatch(PermissionUnion.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for PermissionUnion"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .permission(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}
