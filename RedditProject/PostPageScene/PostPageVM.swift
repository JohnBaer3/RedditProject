//
//  PostPageVM.swift
//  RedditProject
//
//  Created by John Baer on 12/27/22.
//

import Foundation

class PostPageVM {
    let redditService = URLSessionHTTPClient()
    var subredditName: String
    var postID: String
    var commentsArr: [CommentModel] = []
    
    static var commentDataUpdated: String = "CommentDataUpdated"
    
    init(_ subredditName: String, _ postID: String) {
        self.subredditName = subredditName
        self.postID = postID
    }
    
    func fetchData() {
        let endPoint = RedditRequest.getComments(subredditName, postID)
        redditService.request(endPoint, timeout: .Medium) { [weak self] (result: Result<[CommentsResponse], Error>) in
            switch result {
            case .success(let response):
                if response.count > 1 {
                    self?.collapseResponseToModel(response[1], 0)
                }
                
                NotificationCenter.default.post(name: Notification.Name(PostPageVM.commentDataUpdated), object: nil)
            case .failure(let error):
                print(error)
                // call an error popup here
            }
        }
    }
    
    func collapseResponseToModel(_ commentTree: CommentsResponse, _ depth: Int) {
        for child in commentTree.data.children {
            let commentData = child.data
            if let commentBody = commentData.body {
                let model = CommentModel(score: commentData.score, body: commentBody, author: commentData.author, depth: depth)
                commentsArr.append(model)
                
                if case let .responseModel(childCommentTree) = child.data.replies {
                    collapseResponseToModel(childCommentTree, depth + 1)
                }
            }
        }
    }
}
