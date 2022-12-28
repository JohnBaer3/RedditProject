//
//  RemoteImageView.swift
//  RedditProject
//
//  Created by John Baer on 12/26/22.
//

import UIKit

class RemoteImageView: UIImageView {
    func downloadImage(from url: URL?) {
        guard let url = url else {
            self.isHidden = true
            return
        }

        getData(from: url) { data, response, error in
            guard let data = data, error == nil else {
                DispatchQueue.main.async() { [weak self] in
                    self?.isHidden = true
                }
                return
            }
            DispatchQueue.main.async() { [weak self] in
                self?.isHidden = false
                self?.image = UIImage(data: data)
            }
        }
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}
