//
//  User.swift
//  MobileCodingChallenge
//
//  Created by Batuhan Ballı on 2024-01-09.
//

import Foundation

struct User: Codable {
    let id: String?
    let updatedAt: String?
    let username: String?
    let name: String?
    let firstName: String?
    let lastName: String?
    let twitterUsername: String?
    let portfolioUrl: String?
    let bio: String?
    let location: String?
    let links: UserLinks?
    let profileImage: ProfileImage?
    let instagramUsername: String?
    let totalCollections: Int?
    let totalLikes: Int?
    let totalPhotos: Int?
    let totalPromotedPhotos: Int?
    let acceptedTos: Bool?
    let forHire: Bool?
    let social: Social?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case updatedAt = "updatedAt"
        case username = "username"
        case name = "name"
        case firstName = "firstName"
        case lastName = "lastName"
        case twitterUsername = "twitterUsername"
        case portfolioUrl = "portfolioUrl"
        case bio = "bio"
        case location = "location"
        case links = "links"
        case profileImage = "profileImage"
        case instagramUsername = "instagramUsername"
        case totalCollections = "totalCollections"
        case totalLikes = "totalLikes"
        case totalPhotos = "totalPhotos"
        case totalPromotedPhotos = "totalPromotedPhotos"
        case acceptedTos = "acceptedTos"
        case forHire = "forHire"
        case social = "social"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        username = try values.decodeIfPresent(String.self, forKey: .username)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        firstName = try values.decodeIfPresent(String.self, forKey: .firstName)
        lastName = try values.decodeIfPresent(String.self, forKey: .lastName)
        twitterUsername = try values.decodeIfPresent(String.self, forKey: .twitterUsername)
        portfolioUrl = try values.decodeIfPresent(String.self, forKey: .portfolioUrl)
        bio = try values.decodeIfPresent(String.self, forKey: .bio)
        location = try values.decodeIfPresent(String.self, forKey: .location)
        links = try values.decodeIfPresent(UserLinks.self, forKey: .links)
        profileImage = try values.decodeIfPresent(ProfileImage.self, forKey: .profileImage)
        instagramUsername = try values.decodeIfPresent(String.self, forKey: .instagramUsername)
        totalCollections = try values.decodeIfPresent(Int.self, forKey: .totalCollections)
        totalLikes = try values.decodeIfPresent(Int.self, forKey: .totalLikes)
        totalPhotos = try values.decodeIfPresent(Int.self, forKey: .totalPhotos)
        totalPromotedPhotos = try values.decodeIfPresent(Int.self, forKey: .totalPromotedPhotos)
        acceptedTos = try values.decodeIfPresent(Bool.self, forKey: .acceptedTos)
        forHire = try values.decodeIfPresent(Bool.self, forKey: .forHire)
        social = try values.decodeIfPresent(Social.self, forKey: .social)
    }
}
