//
//  TopicSubmission.swift
//  MobileCodingChallenge
//
//  Created by Batuhan Ballı on 2024-01-09.
//

import Foundation

struct TopicSubmission: Codable {
    let wallpapers: Wallpapers?

    enum CodingKeys: String, CodingKey {
        case wallpapers = "wallpapers"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        wallpapers = try values.decodeIfPresent(Wallpapers.self, forKey: .wallpapers)
    }
}

struct Wallpapers: Codable {
    let approvedOn: String?
    let status: String?

    enum CodingKeys: String, CodingKey {
        case approvedOn = "approved_on"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        approvedOn = try values.decodeIfPresent(String.self, forKey: .approvedOn)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }
}

