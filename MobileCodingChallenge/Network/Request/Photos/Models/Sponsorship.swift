//
//  Sponsorship.swift
//  MobileCodingChallenge
//
//  Created by Batuhan Ballı on 2024-01-09.
//

import Foundation

struct Sponsorship: Codable {
    let impressionUrls: [String]?
    let tagline: String?
    let taglineUrl: String?
    let sponsor: Sponsor?
    
    enum CodingKeys: String, CodingKey {
        case impressionUrls = "impression_urls"
        case tagline = "tagline"
        case taglineUrl = "tagline_url"
        case sponsor = "sponsor"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        impressionUrls = try values.decodeIfPresent([String].self, forKey: .impressionUrls)
        tagline = try values.decodeIfPresent(String.self, forKey: .tagline)
        taglineUrl = try values.decodeIfPresent(String.self, forKey: .taglineUrl)
        sponsor = try values.decodeIfPresent(Sponsor.self, forKey: .sponsor)
    }
}

