//
//  PhotoResponse.swift
//  MobileCodingChallenge
//
//  Created by Batuhan Ballı on 2024-01-09.
//

import Foundation

struct PhotoResponse: Codable {
    let id: String?
    let slug: String?
    let createdAt: String?
    let updatedAt: String?
    let promotedAt: String?
    let width: Int?
    let height: Int?
    let color: String?
    let blurHash: String?
    let description: String?
    let altDescription: String?
    let urls: Urls?
    let links: UserLinks?
    let likes: Int?
    let likedByUser: Bool?
    let currentUserCollections: [String]?
    let sponsorship: Sponsorship?
    let topicSubmission: Wallpapers?
    let user: User?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case slug = "slug"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case promotedAt = "promoted_at"
        case width = "width"
        case height = "height"
        case color = "color"
        case blurHash = "blur_hash"
        case description = "description"
        case altDescription = "alt_description"
        case urls = "urls"
        case links = "links"
        case likes = "likes"
        case likedByUser = "liked_by_user"
        case currentUserCollections = "current_user_collections"
        case sponsorship = "sponsorship"
        case topicSubmission = "topic_submissions"
        case user = "user"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        slug = try values.decodeIfPresent(String.self, forKey: .slug)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        promotedAt = try values.decodeIfPresent(String.self, forKey: .promotedAt)
        width = try values.decodeIfPresent(Int.self, forKey: .width)
        height = try values.decodeIfPresent(Int.self, forKey: .height)
        color = try values.decodeIfPresent(String.self, forKey: .color)
        blurHash = try values.decodeIfPresent(String.self, forKey: .blurHash)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        altDescription = try values.decodeIfPresent(String.self, forKey: .altDescription)
        urls = try values.decodeIfPresent(Urls.self, forKey: .urls)
        links = try values.decodeIfPresent(UserLinks.self, forKey: .links)
        likes = try values.decodeIfPresent(Int.self, forKey: .likes)
        likedByUser = try values.decodeIfPresent(Bool.self, forKey: .likedByUser)
        currentUserCollections = try values.decodeIfPresent([String].self, forKey: .currentUserCollections)
        sponsorship = try values.decodeIfPresent(Sponsorship.self, forKey: .sponsorship)
        topicSubmission = try values.decodeIfPresent(Wallpapers.self, forKey: .topicSubmission)
        user = try values.decodeIfPresent(User.self, forKey: .user)
    }
}

//MARK: - Hashable

extension PhotoResponse: Hashable {
    static func == (lhs: PhotoResponse, rhs: PhotoResponse) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into myhasher: inout Hasher) {
        myhasher.combine(id)
    }
}

