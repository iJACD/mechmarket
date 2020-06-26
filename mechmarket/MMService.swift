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
    func loadFeed(for origin: Country, and flair: MMFlair, completion: @escaping (Result<MMEmbededData, Error>) -> ()) {
        let sort = "new"
        let timeFrame = "month"
        let limit = 30
        let urlString = "\(baseURL)/\(subreddit)/search.json?q=\(origin.queryString)\(flair.queryString)&restrict_sr=on&sort=\(sort)&limit=\(limit)&t=\(timeFrame)"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, resp, err in
            if let err = err {
                completion(.failure(err))
                return
            }
            
            do {
                let response = try JSONDecoder().decode(DataPackage<MMEmbededData>.self, from: data ?? Data())
                print("⚪️ Request URL: \(urlString)")
                completion(.success(response.data))
            } catch let jsonErr {
                completion(.failure(jsonErr))
            }
        }.resume()
    }
    
    func loadMoreFeed(after id: String, for origin: Country, and flair: MMFlair, completion: @escaping (Result<MMEmbededData, Error>) -> ()) {
        let sort = "new"
        let timeFrame = "month"
        let limit = 30
        let urlString = "\(baseURL)/\(subreddit)/search.json?q=\(origin.queryString)\(flair.queryString)&restrict_sr=on&sort=\(sort)&limit=\(limit)&after=\(id)&t=\(timeFrame)"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, resp, err in
            if let err = err {
               completion(.failure(err))
               return
            }

            do {
               let response = try JSONDecoder().decode(DataPackage<MMEmbededData>.self, from: data ?? Data())
               print("🔵 Load More Request URL: \(urlString)")
               completion(.success(response.data))
            } catch let jsonErr {
               completion(.failure(jsonErr))
            }
        }.resume()
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
                    print("🛑", error, "\n")
                }
            }.resume()
        }
}
