//
//  Social.swift
//  MobileCodingChallenge
//
//  Created by Batuhan Ballı on 2024-01-09.
//

import Foundation

struct Social: Codable {
    let instagramUsername: String?
    let portfolioUrl: String?
    let twitterUsername: String?
    let paypalEmail: String?
    
    enum CodingKeys: String, CodingKey {
        case instagramUsername = "instagram_username"
        case portfolioUrl = "portfolio_url"
        case twitterUsername = "twitter_username"
        case paypalEmail = "paypal_email"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        instagramUsername = try values.decodeIfPresent(String.self, forKey: .instagramUsername)
        portfolioUrl = try values.decodeIfPresent(String.self, forKey: .portfolioUrl)
        twitterUsername = try values.decodeIfPresent(String.self, forKey: .twitterUsername)
        paypalEmail = try values.decodeIfPresent(String.self, forKey: .paypalEmail)
    }
}

