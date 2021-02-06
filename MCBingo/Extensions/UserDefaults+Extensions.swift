//
//  UserDefaults+Extensions.swift
//  MCBingo
//
//  Created by Matthijs van der Linden on 06/02/2021.
//

import Foundation

// Codable structs can be easily parsed to UserDefaults
extension UserDefaults {
    func set<T: Encodable>(forKey key: String, encodable: T) throws {
        let encoder = JSONEncoder()
        let encoded = try encoder.encode(encodable)
        set(encoded, forKey: key)
    }
    
    func get<T: Decodable>(forKey key: String, decodable: T.Type) -> T? {
        if let object = object(forKey: key) as? Data {
            let decoder = JSONDecoder()
            return try? decoder.decode(decodable, from: object)
        }
        return nil
    }
}
