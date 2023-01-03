//
//  RedditModels.swift
//  RedditProject
//
//  Created by John Baer on 12/26/22.
//

import Foundation

struct RedditResponse : Decodable {
    let data: ListData
}

struct ListData: Decodable {
    let children: [Child]
}

struct Child: Decodable {
    let data: PostData
}

struct PostData : Decodable {
    let preview: Preview?
    let media: Media?
    let id: String
    let title: String
    let subredditName: String
    let authorFullName: String
    let selftext: String
    let thumbnail: String
    let score: Int
    let commentCount: Int?
    let mediaType: String?   // hosted:video     image   link   nil if a text post (like an Askreddit thread)
//    let created: Int  // this should be converted to Date right in the Decodable
    
    enum CodingKeys: String, CodingKey {
        case subredditName = "subreddit_name_prefixed"
        case authorFullName = "author_fullname"
        case media = "secure_media"
        case mediaType = "post_hint"
        case commentCount = "num_comments"
        case preview, id, title, selftext, thumbnail, score
    }
}

struct Preview : Decodable {
    let images: [Images]
}

struct Images : Decodable {
    let source: Image
    let resolutions: [Image]
}
struct Image: Decodable {
    let url: URL
    let width: Int
    let height: Int
}


struct Media: Decodable {
    let redditVideo: RedditVideo?
    
    enum CodingKeys: String, CodingKey {
        case redditVideo = "reddit_video"
    }
}

struct RedditVideo: Decodable {
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case url = "fallback_url"
    }
}
