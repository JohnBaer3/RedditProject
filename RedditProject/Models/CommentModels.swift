//
//  CommentModels.swift
//  RedditProject
//
//  Created by John Baer on 12/27/22.
//

import Foundation

struct CommentModel {
    let score: Int
    let body: String
    let author: String
    let depth: Int
}


class CommentsResponse : Decodable {
    let data: ListingData
}

class ListingData: Decodable {
    let children: [CommentChild]
}

class CommentChild: Decodable {
    let data: CommentData
}

class CommentData : Decodable {
    let score: Int
    let body: String?
    let author: String
    var replies: CommentReplies? // this has to handle both dictionary, String, and nil
}


enum CommentReplies: Decodable {
    case responseModel(CommentsResponse), string(String), empty
    
    init(from decoder: Decoder) throws {
        if let responseModel = try? decoder.singleValueContainer().decode(CommentsResponse.self) {
            self = .responseModel(responseModel)
            return
        }
        
        if let string = try? decoder.singleValueContainer().decode(String.self) {
            self = .string(string)
            return
        }

        self = .empty
        return
    }
}
