//
//  PhotoRouter.swift
//  MobileCodingChallenge
//
//  Created by Batuhan Ballı on 2024-01-09.
//

import Foundation

protocol PhotosRouter: APIRouter {}

extension PhotosRouter {
    func asURLRequest() throws -> URLRequest {
        do {
            let url = try Constant.baseURL.rawValue.asURL() // TODO: Plist can be used
            return try request(url: url)
        } catch {
            throw error
        }
    }
}

