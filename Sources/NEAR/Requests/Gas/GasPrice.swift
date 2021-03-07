//
//  File.swift
//  
//
//  Created by Arturo Jamaica on 2021/03/07.
//

import Foundation

public enum GasPriceRequest: Codable {
    case blockHashes([String])
    case blockHeight([Int])
    case null

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode([String].self) {
            self = .blockHashes(x)
            return
        }
        if let x = try? container.decode([Int].self) {
            self = .blockHeight(x)
            return
        }
        throw DecodingError.typeMismatch(BlockIdFinality.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for BlockIDFinality"))
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .blockHashes(let x):
            try container.encode(x)
        case .blockHeight(let x):
            try container.encode(x)
        case .null:
            try container.encode([JSONNull()])
        }
    }
}


public struct GasPriceResponse: Codable {
    let gasPrice: String

    enum CodingKeys: String, CodingKey {
        case gasPrice = "gas_price"
    }
}
