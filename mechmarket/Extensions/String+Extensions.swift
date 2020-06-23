//
//  String+Extensions.swift
//  mechmarket
//
//  Created by JohnAnthony on 6/15/20.
//  Copyright © 2020 iJACD. All rights reserved.
//

import UIKit

extension String {
    /* Solition below per https://www.hackingwithswift.com/example-code/strings/how-to-detect-a-url-in-a-string-using-nsdatadetector
     */
    /// Returns url string from given string
    func returnUrlString() -> String {
        let input = self
        var urlStrings = [String]()
        let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        let matches = detector.matches(in: input, options: [], range: NSRange(location: 0, length: input.utf16.count))

        for match in matches {
            guard let range = Range(match.range, in: input) else { continue }
            let url = input[range]
            urlStrings.append(String(url))
        }
        
        if let urlString = urlStrings.first(where: {
            $0.contains("imgur") /* Optistically avoids sending back urls in text that aren't images
                                    Does not acount for other image hosts such as google drive. */
        }) {
            return urlString.formatedImgurUrlString
        } else if let urlString = urlStrings.first,
                  let url = URL(string: urlString) {
            if UIApplication.shared.canOpenURL(url) {
                return urlString
            }
        }
        
        return ""
    }
    
    /// Formats given url to imgur api url.
    var formatedImgurUrlString: String {
        var string = self
        string = string.replacingOccurrences(of: "http://", with: "https://").stripped
        string = string.replacingOccurrences(of: "://m.", with: "://")
        
        if !string.contains("/a/") { // checks for album imgur link
            if !string.contains("/gallery/") { // checks for gallery imgur link
                if !string.contains(".jpg") && !string.contains(".png"){ // checks for imgur link already direct link
                    string = string.replacingOccurrences(
                        of: MM.Imgur.baseUrl,
                        with: MM.Imgur.apiBaseUrl+MM.Imgur.image)
                }
            } else {
                string = string.replacingOccurrences(
                    of: MM.Imgur.baseUrl+"/gallery",
                    with: MM.Imgur.apiBaseUrl+MM.Imgur.gallery)
            }
        } else {
            string = string.replacingOccurrences(
                of: MM.Imgur.baseUrl+"/a",
                with: MM.Imgur.apiBaseUrl+MM.Imgur.album)
        }
        return string
    }
    
    var stripped: String {
        let okayChars = Set("abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLKMNOPQRSTUVWXYZ1234567890+-_:/.")
        return self.filter { okayChars.contains($0) }
    }
    
    func flairFromString() -> MMFlair? {
        switch self.lowercased() {
        case "buying":
            return .buying
        case "selling":
            return .selling
        case "trading":
            return.trading
        case "sold":
            return .sold
        case "purchased":
            return .purchased
        default:
            return nil
        }
    }
    
    var htmlToAttributedString: NSAttributedString? {
       guard let data = data(using: .utf8) else { return NSAttributedString() }
       do {
           return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
       } catch {
           return NSAttributedString()
       }
   }

   var htmlToString: String {
       return htmlToAttributedString?.string ?? ""
   }
}
