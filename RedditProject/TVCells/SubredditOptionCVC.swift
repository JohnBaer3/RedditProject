//
//  SubredditOptionCVC.swift
//  RedditProject
//
//  Created by John Baer on 12/27/22.
//

import UIKit

class SubredditOptionCVC: UITableViewCell {

    @IBOutlet weak var subredditLabel: UILabel!
    
    static let reuseIdentifier: String = "SubredditOptionCVC"
    
    func configure(_ subredditName: String) {
        subredditLabel.text = "r/\(subredditName)"
    }
}
