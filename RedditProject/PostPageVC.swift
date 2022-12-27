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
    static let identifier: String = "PostPageVC"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
    }
    
    func setupTableView() {
        tableView.register(UINib(nibName: MainPostTVC.reuseIdentifier, bundle: nil), forCellReuseIdentifier: MainPostTVC.reuseIdentifier)
    }
}

extension PostPageVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // right here - make this a safer unwrapping
        let cell = tableView.dequeueReusableCell(withIdentifier: MainPostTVC.reuseIdentifier) as! MainPostTVC
        cell.configure(postData)
        return cell
    }
}
