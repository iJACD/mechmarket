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
            MMService.shared.getImgurDirectLink(from: urlString) { res in
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
}
