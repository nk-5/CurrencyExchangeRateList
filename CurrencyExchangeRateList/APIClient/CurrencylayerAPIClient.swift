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
    private var accessKey: String?
    private lazy var baseParam: [String: String] = {
        ["access_key": accessKey!]
    }()
    
    private var cancellableSet: Set<AnyCancellable> = []
    
    init(accessKey: String? = nil) {
        if let accessKey = accessKey {
            self.accessKey = accessKey
            return
        }
        
        guard let path = Bundle.main.path(forResource: "CurrencyLayerConfig", ofType: "txt") else {
            precondition(false, "CurrencyLayerConfig file not found and need access key. try make CURRENCY_LAYER_ACCESS_KEY=[access_key]")
        }
        
        do {
            let tmpAccessKey  = try String(contentsOfFile: path, encoding: .utf8)
            self.accessKey = tmpAccessKey.components(separatedBy: "\n")[0]
        } catch {
            precondition(false, "\(error)")
        }
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
                            guard let data = $0, let currencyList = try? JSONDecoder().decode(CurrencyLayerResponse.List.self, from: data) else {
                                promise(.failure(.decodeError))
                                return
                            }
                            promise(.success(Currency.getCurrencies(from: currencyList)))
                            
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
