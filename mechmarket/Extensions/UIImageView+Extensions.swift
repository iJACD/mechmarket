//
//  UIImageView+Extensions.swift
//  mechmarket
//
//  Created by JohnAnthony on 6/11/20.
//  Copyright © 2020 iJACD. All rights reserved.
//

import UIKit

extension UIImageView {
    func loadImage(using urlString: String) {
        var urlString = urlString
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        if urlString.contains("imgur") && !urlString.contains(".jpg") {
            getImgurDirectLink(from: urlString) { res in
                switch res {
                case .success(let string):
                    urlString = string
                case .failure(let err):
                    print("Failed to load imgur link: ", err)
                }
                
                dispatchGroup.leave()
            }
        } else {
            dispatchGroup.leave()
        }

        dispatchGroup.notify(queue: .main) {
            guard let url = URL(string: urlString) else { return }
        
            URLSession.shared.dataTask(with: url) { data, resp, err in
                if let err = err {
                    print(err)
                    return
                }
                
                DispatchQueue.main.async {
                    if let data = data {
                        self.image = UIImage(data: data)
                    }
                }
            }.resume()
        }
    }
    
    private func getImgurDirectLink(from urlString: String, completion: @escaping (Result<String, Error>) -> ()) {
        let urlString = urlString
        guard let url = URL(string: urlString) else { return }
        let request = NSMutableURLRequest(url: url)
        request.setValue(Secrets.CLIENT_ID, forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request as URLRequest) { data, resp, err in
            guard let data = data, err == nil else { return }
            do {
                if urlString.contains("image") {
                    let response = try JSONDecoder().decode(DataPackage<MMImgurImage>.self, from: data)
                    completion(.success(response.data.link))
                } else {
                    let response = try JSONDecoder().decode(DataPackage<MMImgurAlbum>.self, from: data)
                    completion(.success(response.data.images[0].link))
                }
            } catch let error as NSError {
                print(error)
            }
        }.resume()
    }
}
