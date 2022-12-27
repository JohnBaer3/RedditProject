//
//  RedditVC.swift
//  RedditProject
//
//  Created by John Baer on 12/24/22.
//

import UIKit

class MainPage: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    var models: [PostData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        
        fetchData()
        
    }
    
    func setupTableView() {
        tableView.register(UINib(nibName: MainPostTVC.reuseIdentifier, bundle: nil), forCellReuseIdentifier: MainPostTVC.reuseIdentifier)
    }


    func fetchData() {
        guard let url = URL(string: "https://www.reddit.com/r/swift/.json") else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
        guard let data = data else { return }
            do {
                let model = try JSONDecoder().decode(RedditResponse.self, from: data)
                for child in model.data.children {
                    self.models.append(child.data)
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            catch let error as DecodingError {
               switch error {
                        case .typeMismatch(let key, let value):
                          print("error \(key), value \(value) and ERROR: \(error.localizedDescription)")
                        case .valueNotFound(let key, let value):
                          print("error \(key), value \(value) and ERROR: \(error.localizedDescription)")
                        case .keyNotFound(let key, let value):
                          print("error \(key), value \(value) and ERROR: \(error.localizedDescription)")
                        case .dataCorrupted(let key):
                          print("error \(key), and ERROR: \(error.localizedDescription)")
                        default:
                          print("ERROR: \(error.localizedDescription)")
                        }
               }
            catch {
                print(error)
            }

        }
        task.resume()
    }
    
}


extension MainPage: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // right here - make this a safer unwrapping
        let cell = tableView.dequeueReusableCell(withIdentifier: MainPostTVC.reuseIdentifier) as! MainPostTVC
        cell.configure(models[indexPath.row])
        return cell
    }
}

extension MainPage: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let postPageVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: PostPageVC.identifier) as? PostPageVC {
            postPageVC.postData = models[indexPath.row]
            navigationController?.pushViewController(postPageVC, animated: true)
        }
    }
}



