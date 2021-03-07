import Foundation

enum Action: Codable {
    case actionClass(ActionClass)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        if let x = try? container.decode(ActionClass.self) {
            self = .actionClass(x)
            return
        }
        throw DecodingError.typeMismatch(Action.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for ActionElement"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .actionClass(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

struct ActionClass: Codable {
    let transfer: Transfer?
    let addKey: Key?

    enum CodingKeys: String, CodingKey {
        case transfer = "Transfer"
        case addKey = "AddKey"
    }
}
