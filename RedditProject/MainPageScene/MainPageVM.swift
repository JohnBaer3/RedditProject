//
//  MainPageVM.swift
//  RedditProject
//
//  Created by John Baer on 12/27/22.
//

import Foundation

class MainPageVM {
    
    var currentSubreddit: String = ""
    var models: [PostData] = []
    let redditService = URLSessionHTTPClient()
    
    static var subredditDataUpdated: String = "SubredditDataUpdated"
    
    init(_ currentSubreddit: String) {
        self.currentSubreddit = currentSubreddit
    }
    
    func fetchData(_ subredditName: String, paging: Bool = false) {
        currentSubreddit = subredditName
        let endPoint = RedditRequest.getFeed(subredditName)
        redditService.request(endPoint, timeout: .Medium) { [weak self] (result: Result<RedditResponse, Error>) in
            switch result {
            case .success(let response):
                if !paging {
                    self?.models = []
                }
                response.data.children.forEach { self?.models.append($0.data) }
                NotificationCenter.default.post(name: Notification.Name(MainPageVM.subredditDataUpdated), object: nil)
            case .failure(let error):
                print(error)
                // call an error popup here
            }
        }
    }
}

