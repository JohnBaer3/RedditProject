//
//  RedditVC.swift
//  RedditProject
//
//  Created by John Baer on 12/24/22.
//

import UIKit

class RedditVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        fetchData()
        
    }


    func fetchData() {
        guard let url = URL(string: "https://www.reddit.com/r/popular/.json") else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
        guard let data = data else { return }
            do {
                let model = try JSONDecoder().decode(RedditResponse.self, from: data)
//                for child in model.data.children {
//                    print(child.data.media?.redditVideo.url)
//                }
            }
            catch {
            }
        }
        task.resume()
    }
    
}



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
    let title: String
    let subredditName: String
    let authorFullName: String
    let selftext: String
    let thumbnail: String?
    let ups: Int
    let downs: Int
    let mediaType: String?   // hosted:video     image   link   nil if a text post (like an Askreddit thread)
//    let created: Int  // this should be converted to Date right in the Decodable
    
    enum CodingKeys: String, CodingKey {
        case subredditName = "subreddit_name_prefixed"
        case authorFullName = "author_fullname"
        case media = "secure_media"
        case mediaType = "post_hint"
        case preview, title, selftext, thumbnail, ups, downs
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
    let redditVideo: RedditVideo
    
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
