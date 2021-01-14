//
//  APIClient.swift
//  CurrencyExchangeRateList
//
//  Created by Keigo Nakagawa on 2021/01/11.
//

import Alamofire
import Combine
import Foundation

class APIClient {
    static let shared = APIClient()
    
    private init() {}
    
    func request(url: String, method: HTTPMethod = .get, param: [String: String] = [:]) -> Future<Data?, AFError> {
        return Future<Data?, AFError> { promise in
            AF.request(url,
                       method: method,
                       parameters: param,
                       encoder: URLEncodedFormParameterEncoder.default).response { response in
                        debugPrint(response)
                        
                        if let error = response.error {
                            promise(.failure(error))
                            return
                        }
                        
                        promise(.success(response.data))
            }
        }
    }
}
