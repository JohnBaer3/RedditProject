//
//  MainPostTVC.swift
//  RedditProject
//
//  Created by John Baer on 12/26/22.
//

import UIKit

class MainPostTVC: UITableViewCell {

    @IBOutlet weak var subredditName: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var thumbnailImage: RemoteImageView!
    @IBOutlet weak var voteLabel: UILabel!
    @IBOutlet weak var commentButton: UIButton!
    
    static let reuseIdentifier = "MainPostTVC"
    
    @IBAction func upvoteClick(_ sender: UIButton) {
        
    }
    
    @IBAction func downvoteClick(_ sender: UIButton) {
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(_ model: PostData) {
        subredditName.text = model.subredditName
        subtitle.text = "u/\(model.authorFullName)"
        title.text = model.title
        voteLabel.text = String(model.score)
        commentButton.setTitle(String(model.commentCount ?? 0), for: .normal)
        thumbnailImage.downloadImage(from: URL(string: model.thumbnail))
    }
}
