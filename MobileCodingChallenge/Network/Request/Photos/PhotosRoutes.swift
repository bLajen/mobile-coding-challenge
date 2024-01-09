//
//  PhotosRoutes.swift
//  MobileCodingChallenge
//
//  Created by Batuhan Ballı on 2024-01-09.
//

import Alamofire

enum PhotosRoutes {
    case getPhotos
}

extension PhotosRoutes: PhotosRouter {
    var method: HTTPMethod {
        switch self {
        case .getPhotos:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .getPhotos: return "photos"
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case let .getPhotos:
            return nil
        }
    }
}

