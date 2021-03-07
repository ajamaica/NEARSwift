import Foundation

struct Value: Codable {
    let key, value: String
    let proof: [JSONAny]
}
