//
//  NativeRequestable.swift
//  check24-Task
//
//  Created by admin on 22/05/2023.
//

import Combine
import Foundation
import Foundation
import Combine

public class NativeRequestable: Requestable {
    
    public var requestTimeOut: Float = 30
    
    public init() {}
    
    public func request<T: Decodable>(
        _ req: NetworkRequest
    ) -> AnyPublisher<T, NetworkError> {
        
        guard let urlString = req.url,
              let url = URL(string: urlString) else {
            return Fail(error: NetworkError.badURL("Invalid URL"))
                .eraseToAnyPublisher()
        }
        
        let request = req.buildURLRequest(with: url)
        
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .tryMap { output -> Data in
                print(String(data: output.data, encoding: .utf8) ?? "❌ NO BODY")
                guard let response = output.response as? HTTPURLResponse else {
                    throw NetworkError.noResponse("No HTTP response")
                }
                
                print("✅ HTTP Status:", response.statusCode)
                print("✅ URL:", response.url?.absoluteString ?? "")
                print("✅ response", response)

    
                switch response.statusCode {

                case 200...299:
                    return output.data
                    
                case 401:
                    throw NetworkError.unauthorized(
                        code: response.statusCode,
                        error: "Unauthorized"
                    )
                    
                case 400...499:
                    throw NetworkError.badRequest(
                        code: response.statusCode,
                        error: "Client error"
                    )
                    
                case 500...599:
                    throw NetworkError.serverError(
                        code: response.statusCode,
                        error: "Server error"
                    )
                    
                default:
                    throw NetworkError.unknown(
                        code: response.statusCode,
                        error: "Unknown error"
                    )
                }
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                if let networkError = error as? NetworkError {
                    return networkError
                } else {
                    return NetworkError.invalidJSON(error.localizedDescription)
                }
            }
            .receive(on: DispatchQueue.main) // ✅ REQUIRED
            .eraseToAnyPublisher()
    }
}

