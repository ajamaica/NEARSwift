import Foundation

enum Finality: String, Codable {
    case optimistic
    case near_final = "near-final"
    case final
}
