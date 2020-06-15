//
//  MMListing.swift
//  mechmarket
//
//  Created by JohnAnthony on 6/12/20.
//  Copyright © 2020 iJACD. All rights reserved.
//

import UIKit

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
            selftext.returnUrlString()
        }
    }
}
