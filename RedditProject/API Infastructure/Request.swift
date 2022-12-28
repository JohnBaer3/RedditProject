//
//  Request.swift
//  RedditProject
//
//  Created by John Baer on 12/26/22.
//

import Foundation

public protocol Request {
    var scheme: HTTPScheme { get }
    var host: String { get }
    var path: String { get }
    var method : HTTPMethod { get }
    var parameters : [URLQueryItem] { get }
    var headers : [String: Any]? { get }
}

public enum HTTPScheme: String {
    case http = "http"
    case https = "https"
}

public enum HTTPMethod: String {
    case post = "POST"
    case put = "PUT"
    case get = "GET"
    case delete = "DELETE"
    case patch = "PATCH"
}



