//
//  RedditRequest.swift
//  RedditProject
//
//  Created by John Baer on 12/27/22.
//

import Foundation

enum RedditRequest: Request {
    case getFeed(String, String?), getComments(String, String)
    
    var scheme: HTTPScheme {
        return .https
    }
    
    var host: String {
        return "www.reddit.com"
    }
    
    var path: String {
        switch self {
        case .getFeed(let subredditName, _):
            return "/r/\(subredditName)/.json"
        case .getComments(let subredditName, let postID):
            return "/\(subredditName)/comments/\(postID)/.json"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getFeed(_, _):
            return .get
        case .getComments(_, _):
            return .get
        }
    }
    
    var parameters: [URLQueryItem] {
        switch self {
        case .getFeed(_, let lastPostID):
            var queryItems: [URLQueryItem] = []
            
            let imageParam = URLQueryItem(name: "raw_json", value: "1")
            queryItems.append(imageParam)
            
            let queryLimit = URLQueryItem(name: "count", value: "25")
            queryItems.append(queryLimit)
            
            if let lastPostID = lastPostID {
                let beforeParam = URLQueryItem(name: "after", value: lastPostID)
                queryItems.append(beforeParam)
            }
            
            return queryItems
            
        case .getComments(_, _):
            return []
        }
    }
    
    var headers: [String : Any]? {
        return [:]
    }
}
