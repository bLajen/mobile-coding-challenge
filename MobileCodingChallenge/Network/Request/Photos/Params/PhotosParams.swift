//
//  PhotosParams.swift
//  MobileCodingChallenge
//
//  Created by Batuhan Ballı on 2024-01-10.
//

import Foundation

struct PhotosParams: Encodable {
    let clientId: String?
    let page: String?
    let perPage: String?
    
    enum CodingKeys: String, CodingKey {
        case clientId = "client_id"
        case page = "page"
        case perPage = "per_page"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encodeIfPresent(clientId, forKey: .clientId)
        try container.encodeIfPresent(page, forKey: .page)
        try container.encodeIfPresent(perPage, forKey: .perPage)
    }
}
