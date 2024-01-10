//
//  UserLinks.swift
//  MobileCodingChallenge
//
//  Created by Batuhan Ballı on 2024-01-09.
//

import Foundation

struct UserLinks: Codable {
    let selfLink: String?
    let html: String?
    let photos: String?
    let likes: String?
    let portfolio: String?
    let following: String?
    let followers: String?
    
    enum CodingKeys: String, CodingKey {
        case selfLink = "self"
        case html = "html"
        case photos = "photos"
        case likes = "likes"
        case portfolio = "portfolio"
        case following = "following"
        case followers = "followers"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        selfLink = try values.decodeIfPresent(String.self, forKey: .selfLink)
        html = try values.decodeIfPresent(String.self, forKey: .html)
        photos = try values.decodeIfPresent(String.self, forKey: .photos)
        likes = try values.decodeIfPresent(String.self, forKey: .likes)
        portfolio = try values.decodeIfPresent(String.self, forKey: .portfolio)
        following = try values.decodeIfPresent(String.self, forKey: .following)
        followers = try values.decodeIfPresent(String.self, forKey: .followers)
    }
}

