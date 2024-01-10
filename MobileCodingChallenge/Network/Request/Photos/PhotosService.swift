//
//  PhotosService.swift
//  MobileCodingChallenge
//
//  Created by Batuhan Ballı on 2024-01-09.
//

import Alamofire

protocol PhotosServiceProtocol: AnyObject {
    func getPhotos(params: PhotosParams) -> APIPublisher<[PhotoResponse]>
}

class PhotosService: PhotosServiceProtocol, APIService {
    static let shared = PhotosService() // TODO: Consider inject
    
    typealias RouteType = PhotosRoutes
    
    private init() {}
    
    func getPhotos(params: PhotosParams) -> APIPublisher<[PhotoResponse]> {
        request(route: .getPhotos(params))
    }
}
