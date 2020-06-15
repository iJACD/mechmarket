//
//  MMService.swift
//  mechmarket
//
//  Created by JohnAnthony on 6/12/20.
//  Copyright © 2020 iJACD. All rights reserved.
//

import Foundation

struct MMService {
    private let baseURL = "https://www.reddit.com"
    private let subreddit = "r/mechmarket"
    
    static let shared = MMService()
    
    /// Loads feed for specified origin, and flair from mechmarket subreddit. Ordering by new.
    func loadFeed(for origin: Country, and flair: MMFlair, completion: @escaping (Result<[MMListingData], Error>) -> ()) {
        let urlString = "\(baseURL)/\(subreddit)/search.json?q=\(origin.queryString)\(flair.description)&restrict_sr=on&sort=new&limit=30"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, resp, err in
            if let err = err {
                completion(.failure(err))
                return
            }
            
            do {
                let response = try JSONDecoder().decode(DataPackage<MMEmbededData>.self, from: data ?? Data())
                completion(.success(response.data.children))
            } catch let jsonErr {
                completion(.failure(jsonErr))
            }
        }.resume()
    }
    
    func loadMoreFeed(after id: String, in dist: String, for origin: Country, and flair: MMFlair, completion: @escaping (Result<[MMListingData], Error>) -> ()) {
        
    }
    
    func getImgurDirectLink(from urlString: String, completion: @escaping (Result<String, Error>) -> ()) {
            let urlString = urlString
            guard let url = URL(string: urlString) else { return }
            let request = NSMutableURLRequest(url: url)
            request.setValue(Secrets.CLIENT_ID.key, forHTTPHeaderField: "Authorization")
            request.httpMethod = "GET"
        
            URLSession.shared.dataTask(with: request as URLRequest) { data, resp, err in
                if let err = err {
                    completion(.failure(err))
                    return
                }
                
                guard let data = data else { return }
                
                do {
                    if urlString.contains("image") {
                        let response = try JSONDecoder().decode(DataPackage<MMImgurImage>.self, from: data)
                        completion(.success(response.data.link))
                    } else if urlString.contains("gallery") {
                        let response = try JSONDecoder().decode(DataPackage<MMImgurGallery>.self, from: data)
                        completion(.success(response.data.images[0].link))
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
