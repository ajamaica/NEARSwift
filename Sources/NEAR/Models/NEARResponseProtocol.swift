import Foundation

public struct NEARResponse<Result: Decodable>: Decodable {
    let jsonrpc: String
    let id: String
    let result: Result?
    let error: NEARError?
}

public struct NEARError: Error, Decodable {
    static let canNotReadError = NEARError(code: -1, message: "Unkown Error code from bitso", data: nil)
    let code: Int
    let message: String?
    let data: String?
}
