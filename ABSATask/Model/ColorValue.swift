//
//  HexModel.swift
//  ABSATask
//
//  Created by Dnyaneshwar on 09/06/21.
//

import Foundation


struct ColorValue : Codable {
    
    let hex : Hex?
    
    enum CodingKeys: String, CodingKey {
        case hex = "hex"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        hex = try values.decodeIfPresent(Hex.self, forKey: .hex)
    }
}

struct Hex : Codable {
    let value : String?
    let clean : String?
    
    enum CodingKeys: String, CodingKey {
        case value = "value"
        case clean = "clean"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        value = try values.decodeIfPresent(String.self, forKey: .value)
        clean = try values.decodeIfPresent(String.self, forKey: .clean)
    }
}
