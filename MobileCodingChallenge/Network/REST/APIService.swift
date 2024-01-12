//
//  APIService.swift
//  MobileCodingChallenge
//
//  Created by Batuhan Ballı on 2024-01-09.
//

import Alamofire
import Combine
import Foundation

typealias APIPublisher<T: Decodable> = ErrorPublisher<T>

protocol APIService {
    associatedtype RouteType: APIRouter
    
    func request<T: Decodable>(session: Session, route: RouteType, queue: DispatchQueue) -> APIPublisher<T>
}

extension APIService {
    //Makes an API request and returns a publisher for the response
    func request<T: Decodable>(session: Session = .default,
                               route: RouteType,
                               queue: DispatchQueue = .main) -> APIPublisher<T> {
        session
            .request(route)
            .validate()
            .publishDecodable(type: T.self)
            .value()
            .mapError { $0 }
            .receive(on: queue)
            .eraseToAnyPublisher()
    }
}
