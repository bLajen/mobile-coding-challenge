//
//  APIClient.swift
//  MobileCodingChallenge
//
//  Created by Batuhan Ballı on 2024-01-09.
//

import Alamofire
import Foundation

typealias APIResult<Success: Decodable> = Result<Success, APIError>
typealias APICompletion<Success: Decodable> = (APIResult<Success>) -> Void
typealias Response = AFDataResponse<Any>

protocol APIClient {
    associatedtype RouteType: APIRouter
    static func decodeResponse<T: Decodable>(response: Response, completion: @escaping APICompletion<T>)
}

extension APIClient {
    static func decodeResponse<T: Decodable>(response: Response, completion: @escaping APICompletion<T>) {
        switch response.result {
        case .success:
            guard let data = response.data else {
                completion(.failure(.missingData))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                completion(.success(result))
            } catch {
                print("Error decoding model of type \(T.self): \(error)")
                completion(.failure(.jsonParsingError))
            }
            
        case let .failure(error):
            completion(.failure(.network(error)))
        }
    }
}
