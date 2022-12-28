//
//  RedditVC.swift
//  RedditProject
//
//  Created by John Baer on 12/24/22.
//

import UIKit

class MainPage: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    @IBAction func optionButtonClicked(_ sender: Any) {
        if let subredditOptionVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: SubredditOptionVC.identifier) as? SubredditOptionVC {
            subredditOptionVC.delegate = self
            self.present(subredditOptionVC, animated: true)
        }
    }
    
    private var viewModel = MainPageVM("ufc")
    private let numCellsRemainingToFetchNext = 10
    private var loading = false
        
    convenience init(viewModel: MainPageVM) {
        self.init()
        self.viewModel = viewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNotifications()
        setupTableView()
        
        viewModel.fetchData("ufc")
    }
    
    func setupNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateUINotif(notification:)), name: Notification.Name(MainPageVM.subredditDataUpdated), object: nil)
    }
    
    @objc func updateUINotif(notification: Notification) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.loading = false
        }
    }
    
    func setupTableView() {
        tableView.showsVerticalScrollIndicator = false
        tableView.register(UINib(nibName: MainPostTVC.reuseIdentifier, bundle: nil), forCellReuseIdentifier: MainPostTVC.reuseIdentifier)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: Notification.Name(MainPageVM.subredditDataUpdated), object: nil)
    }
}

extension MainPage: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainPostTVC.reuseIdentifier) as! MainPostTVC
        cell.configure(viewModel.models[indexPath.row], inMainPage: true)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if viewModel.models.count - indexPath.row <= numCellsRemainingToFetchNext && !loading {
            loading = true
            viewModel.fetchData(viewModel.currentSubreddit, paging: true)
        }
    }
}

extension MainPage: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let postPageVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: PostPageVC.identifier) as? PostPageVC {
            postPageVC.postData = viewModel.models[indexPath.row]
            navigationController?.pushViewController(postPageVC, animated: true)
        }
    }
}

extension MainPage: SubredditOptionDelegate {
    func selectedSubreddit(_ subredditName: String) {
        viewModel.fetchData(subredditName)
    }
}

