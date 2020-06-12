//
//  MMListing.swift
//  mechmarket
//
//  Created by JohnAnthony on 6/12/20.
//  Copyright © 2020 iJACD. All rights reserved.
//

import Foundation

struct MMEmbededData: Decodable {
    let after: String?
    let dist: Int
    let children: [MMListingData]
}

struct MMListingData: Decodable {
    let data: MMListing
}

struct MMListing: Decodable {
    let selftext: String
    let author_fullname: String
    let title: String
    let link_flair_text: String
    let selftext_html: String?
    let author: String
    let url: String
    var imageUrlString: String {
        get {
            returnUrl(from: selftext)
        }
    }
    
    /* Solition below per https://www.hackingwithswift.com/example-code/strings/how-to-detect-a-url-in-a-string-using-nsdatadetector
     */
    func returnUrl(from text: String) -> String {
        let input = text
        var urlStrings = [String]()
        let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        let matches = detector.matches(in: input, options: [], range: NSRange(location: 0, length: input.utf16.count))

        for match in matches {
            guard let range = Range(match.range, in: input) else { continue }
            let url = input[range]
            urlStrings.append(String(url))
        }
        
        guard let urlString = urlStrings.first else { return "" }
        
        if urlString.contains("imgur") {
            return formatImgurUrl(from: urlString)
        } else {
            return urlString
        }
    }
    
    func formatImgurUrl(from string: String) -> String {
        var string = string
        if !string.contains("/a") {
            if !string.contains("/gallery") {
                if !string.contains(".jpg") {
                    string = string.replacingOccurrences(of: "https://imgur.com", with: "https://api.imgur.com/3/image")
                }
            } else {
                string = string.replacingOccurrences(of: "https://imgur.com/gallery",
                                                                with: "https://api.imgur.com/3/gallery/album")
            }
        } else {
            string = string.replacingOccurrences(of: "https://imgur.com/a",
                                                 with: "https://api.imgur.com/3/album")
        }
        return string
    }
}
