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
    @IBOutlet weak var selfTextLabel: UILabel!
    @IBOutlet weak var postImage: RemoteImageView!
    @IBOutlet weak var postImageHeight: NSLayoutConstraint!
    @IBOutlet weak var voteLabel: UILabel!
    @IBOutlet weak var commentButton: UIButton!
    
    static let reuseIdentifier = "MainPostTVC"
    
    private var screenWidth: CGFloat {
        return UIScreen.main.bounds.width
    }

    
    @IBAction func upvoteClick(_ sender: UIButton) {
        
    }
    
    @IBAction func downvoteClick(_ sender: UIButton) {
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(_ model: PostData, inMainPage: Bool) {
        subredditName.text = model.subredditName
        subtitle.text = "u/\(model.authorFullName)"
        title.text = model.title
        selfTextLabel.text = model.selftext
        voteLabel.text = String(model.score)
        commentButton.setTitle(String(model.commentCount ?? 0), for: .normal)
        
        if let image = model.preview?.images.first {
            postImage.downloadImage(from: image.source.url)
            let imageHeight = screenWidth / CGFloat(image.source.width) * CGFloat(image.source.height)
            postImageHeight.constant = CGFloat(imageHeight)
        } else {
            postImage.isHidden = true
            postImageHeight.constant = 0
        }
        
        toggleMainPage(inMainPage)
    }
    
    func toggleMainPage(_ inMainPage: Bool) {
        self.selfTextLabel.isHidden = inMainPage
        subtitle.textColor = inMainPage ? .black : .blue
        
        // additional stuff like showing title as grayer if it's already been visited
    }
}
