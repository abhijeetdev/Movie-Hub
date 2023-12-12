//
//  Service.swift
//  MovieHub
//
//  Created by Abhijeet Banarase on 09/12/2023.
//

import Foundation

protocol ServiceProtocol {
    func GET<T: Decodable>(request: Request, completion: @escaping (Result<T, Error>) -> Void)
}

enum ServiceError: Error {
    case failToCreateRequest
    case invalidResponse
    case statusCode(Int)
    case noData
    
    var localizedDescription: String {
        switch self {
        case .failToCreateRequest:
            return "Failed to create the request."
        case .invalidResponse:
            return "Received an invalid response."
        case .statusCode(let code):
            return "Received an unexpected status code: \(code)"
        case .noData:
            return "No data received in the response."
        }
    }
    var errorUserInfo: [String : Any] {
        [NSLocalizedDescriptionKey: localizedDescription]
    }
}

final class Service: ServiceProtocol {
    
    public static let shared = Service(session: URLSession.shared)
        
    private let session: URLSession
        
    init(session: URLSession) {
        self.session = session
    }
    
    func GET<T>(request: Request, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        guard let urlRequest = self.request(form: request, method: "GET") else {
            completion(.failure(ServiceError.failToCreateRequest))
            return
        }

        let task = session.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(ServiceError.invalidResponse))
                return
            }

            guard (200..<300).contains(httpResponse.statusCode) else {
                completion(.failure(ServiceError.statusCode(httpResponse.statusCode)))
                return
            }

            guard let data = data else {
                completion(.failure(ServiceError.noData))
                return
            }

            do {
                let result = try Utils.jsonDecoder.decode(T.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }

        task.resume()
    }
    
    // MARK: - Private
    private func request(form rmRequest: Request, method: String) -> URLRequest? {
        guard let url = rmRequest.url else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        return request
    }
}
