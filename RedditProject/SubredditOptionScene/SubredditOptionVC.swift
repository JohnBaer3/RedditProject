//
//  SubredditOptionVC.swift
//  RedditProject
//
//  Created by John Baer on 12/27/22.
//

import UIKit

protocol SubredditOptionDelegate: AnyObject {
    func selectedSubreddit(_ subredditName: String)
}

class SubredditOptionVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    static let identifier: String = "SubredditOptionVC"
    
    weak var delegate: SubredditOptionDelegate?
    let subreddits: [String] = ["Popular", "ufc", "apple", "bartenders", "dontflinch", "Futurology", "Art", "bestoftwitter"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
    }
    
    func setupTableView() {
        tableView.register(UINib(nibName: SubredditOptionCVC.reuseIdentifier, bundle: nil), forCellReuseIdentifier: SubredditOptionCVC.reuseIdentifier)
    }
}

extension SubredditOptionVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subreddits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SubredditOptionCVC.reuseIdentifier) as! SubredditOptionCVC
        cell.configure(subreddits[indexPath.row])
        return cell
    }
}

extension SubredditOptionVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.dismiss(animated: true) { [weak self] in
            self?.delegate?.selectedSubreddit(self?.subreddits[indexPath.row] ?? "")
        }
    }
}
