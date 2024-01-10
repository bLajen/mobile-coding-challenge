//
//  Encodable+JSON.swift
//  MobileCodingChallenge
//
//  Created by Batuhan Ballı on 2024-01-10.
//

import Foundation

extension Encodable {
    var json: [String: Any]? {
        guard
            let data = try? JSONEncoder().encode(self),
            let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        else { return nil }
        
        return json
    }
}
