//
//  PostPageVC.swift
//  RedditProject
//
//  Created by John Baer on 12/26/22.
//

import UIKit

class PostPageVC: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    var postData: PostData!

    lazy var viewModel = PostPageVM(postData.subredditName, postData.id)
    static let identifier: String = "PostPageVC"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupNotifications()
        
        viewModel.fetchData()
    }
    
    func setupTableView() {
        tableView.register(UINib(nibName: MainPostTVC.reuseIdentifier, bundle: nil), forCellReuseIdentifier: MainPostTVC.reuseIdentifier)
        tableView.register(UINib(nibName: CommentTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: CommentTableViewCell.reuseIdentifier)
    }
    
    func setupNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateUINotif(notification:)), name: Notification.Name(PostPageVM.commentDataUpdated), object: nil)
    }
    
    @objc func updateUINotif(notification: Notification) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension PostPageVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
           return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return viewModel.commentsArr.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: MainPostTVC.reuseIdentifier) as! MainPostTVC
            cell.configure(postData, inMainPage: false)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: CommentTableViewCell.reuseIdentifier) as! CommentTableViewCell
            let model = viewModel.commentsArr[indexPath.row]
            cell.configure(model.body, model.author, model.score, model.depth)
            return cell
        }
    }
}
