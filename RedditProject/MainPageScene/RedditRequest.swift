//
//  RedditRequest.swift
//  RedditProject
//
//  Created by John Baer on 12/27/22.
//

import Foundation

enum RedditRequest: Request {
    case getFeed(String), getComments(String)
    
    var scheme: HTTPScheme {
        return .https
    }
    
    var host: String {
        return "www.reddit.com"
    }
    
    var path: String {
        switch self {
        case .getFeed(let subredditName):
            return "/r/\(subredditName)/.json"
        case .getComments(let postId):
            return "/\(postId)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getFeed(_):
            return .get
        case .getComments(_):
            return .get
        }
    }
    
    var parameters: [URLQueryItem] {
        switch self {
        case .getFeed(_):
            let imageParam = URLQueryItem(name: "raw_json", value: "1")
            return [imageParam]
        case .getComments(_):
            return []
        }
    }
    
    var headers: [String : Any]? {
        return [:]
    }
}
