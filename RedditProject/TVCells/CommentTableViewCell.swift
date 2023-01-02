//
//  CommentTableViewCell.swift
//  RedditProject
//
//  Created by John Baer on 1/1/23.
//

import UIKit

class CommentTableViewCell: UITableViewCell {

    @IBOutlet var dividerLines: [UIView]!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    static let reuseIdentifier = "CommentTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
    }

    func configure(_ bodyText: String, _ userNameText: String, _ score: Int, _ depth: Int) {
        usernameLabel.text = userNameText
        bodyLabel.text = bodyText
        scoreLabel.text = String(score)
        
        var count = 0
        for dividerLine in dividerLines {
            if count < depth {
                dividerLine.isHidden = false
            } else {
                dividerLine.isHidden = true
            }
            count += 1
        }
    }
}
