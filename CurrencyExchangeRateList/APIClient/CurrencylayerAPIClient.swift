//
//  CurrencylayerAPIClient.swift
//  CurrencyExchangeRateList
//
//  Created by Keigo Nakagawa on 2021/01/10.
//

import Foundation
import Combine

enum CurrencylayerAPIError: Error {
    case getFailed
    case decodeError
}

// refs: https://currencylayer.com/documentation
class CurrencylayerAPIClient: CurrencylayerAPIClientProtocol {
    private let endpoint = "http://api.currencylayer.com/"
    private let accessKey = "hoge"
    private let baseParam: [String: String]
    
    private var cancellableSet: Set<AnyCancellable> = []
    
    init() {
        self.baseParam = [
            "access_key": accessKey
        ]
    }
    
    func getCurrencies() -> Future<[Currency], CurrencylayerAPIError> {
        return Future<[Currency], CurrencylayerAPIError> { promise in
            APIClient.shared.request(url: self.endpoint + "list", param: self.baseParam)
                        .sink(receiveCompletion: { completion in
                            switch completion {
                            case .failure(let error):
                                promise(.failure(.getFailed))
                            case .finished: break
                            }
                        }, receiveValue: {
                            guard let data = $0, let currencies = try? JSONDecoder().decode([Currency].self,
                                                                          from: JSONSerialization.data(withJSONObject: data)) else {
                                promise(.failure(.decodeError))
                                return
                            }
                            promise(.success(currencies))
                            
                        })
                .store(in: &self.cancellableSet)
        }
        
    }
    
    func getCurrencyRates(source: String) -> [ExchangeRate] {
        let jsonString = CurrencylayerResponseData.live
        guard let liveExchangeRate = try? JSONDecoder().decode(CurrencyLayerResponse.Live.self, from: jsonString.data(using: .utf8)!) else { return [] }

        return ExchangeRate.getExchangeRates(from: liveExchangeRate)
    }
    
}
