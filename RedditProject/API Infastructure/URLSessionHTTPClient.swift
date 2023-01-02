//
//  URLSessionHTTPClient.swift
//  RedditProject
//
//  Created by John Baer on 12/26/22.
//

import Foundation

class URLSessionHTTPClient {
    enum NetworkError: Error {
        case invalidURL, timeOut, invalidDataFormat, noData
    }
    
    typealias Timeout = TimeInterval
    
    private let session: URLSession
    private struct UnexpectedError: Error {}
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func request<T: Decodable>(_ endpoint: Request, timeout: Timeout = .Short, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = buildURL(endpoint) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endpoint.method.rawValue
        urlRequest.timeoutInterval = timeout

        let dataTask = session.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard response != nil, let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            do {
                let responseObject = try JSONDecoder().decode(T.self, from: data)
                completion(.success(responseObject))
            } catch let jsonError as NSError {
                print(String(describing: jsonError))
            }
        }

        dataTask.resume()
    }
    
    private func buildURL(_ endpoint: Request) -> URL? {
        var query = URLComponents()
        query.scheme = endpoint.scheme.rawValue
        query.host = endpoint.host
        query.path = endpoint.path
        query.queryItems = endpoint.parameters
        return query.url
    }
}

extension URLSessionHTTPClient.Timeout {
    static let Short = TimeInterval(5)
    static let Medium = TimeInterval(10)
    static let Long = TimeInterval(20)
    static let ExtraLong = TimeInterval(30)
}



